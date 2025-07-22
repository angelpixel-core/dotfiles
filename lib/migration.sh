#!/usr/bin/env bash
# lib/migration.sh - Migration system for dotfiles version upgrades

set -euo pipefail

# Source common functions
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"
source "$(dirname "${BASH_SOURCE[0]}")/version.sh"

# Migration constants
[[ -z "${MIGRATIONS_DIR:-}" ]] && readonly MIGRATIONS_DIR="${DOTFILES_ROOT}/migrations"
[[ -z "${MIGRATION_LOG:-}" ]] && readonly MIGRATION_LOG="${DOTFILES_ROOT}/.migration.log"
[[ -z "${MIGRATION_PATTERN:-}" ]] && readonly MIGRATION_PATTERN="^([0-9]+\.[0-9]+\.[0-9]+)_to_([0-9]+\.[0-9]+\.[0-9]+)\.sh$"

# Log migration event
log_migration() {
  local from_version="$1"
  local to_version="$2"
  local status="$3"
  local timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  
  echo "${timestamp}|${from_version}|${to_version}|${status}" >> "$MIGRATION_LOG"
}

# Get available migrations
get_available_migrations() {
  local from_version="$1"
  local to_version="$2"
  
  # Find all migration files
  find "$MIGRATIONS_DIR" -name "*.sh" -type f | while read -r migration_file; do
    local filename=$(basename "$migration_file")
    
    if [[ "$filename" =~ $MIGRATION_PATTERN ]]; then
      local mig_from="${BASH_REMATCH[1]}"
      local mig_to="${BASH_REMATCH[2]}"
      
      # Check if this migration is in our path
      if compare_versions "$from_version" "$mig_from" &>/dev/null && \
         compare_versions "$mig_to" "$to_version" &>/dev/null; then
        echo "$migration_file"
      fi
    fi
  done | sort
}

# Build migration path
build_migration_path() {
  local from_version="$1"
  local to_version="$2"
  local -a migration_path=()
  
  # Get all migrations between versions
  local current_version="$from_version"
  
  while compare_versions "$current_version" "$to_version" &>/dev/null; do
    local result=$?
    [[ $result -eq 0 ]] && break  # Versions are equal
    
    # Find next migration from current version
    local next_migration=""
    local next_version=""
    
    for migration in "$MIGRATIONS_DIR"/*.sh; do
      [[ -f "$migration" ]] || continue
      
      local filename=$(basename "$migration")
      if [[ "$filename" =~ $MIGRATION_PATTERN ]]; then
        local mig_from="${BASH_REMATCH[1]}"
        local mig_to="${BASH_REMATCH[2]}"
        
        if [[ "$mig_from" == "$current_version" ]]; then
          if [[ -z "$next_version" ]] || compare_versions "$mig_to" "$next_version" &>/dev/null; then
            next_migration="$migration"
            next_version="$mig_to"
          fi
        fi
      fi
    done
    
    if [[ -z "$next_migration" ]]; then
      log_error "No migration path found from $current_version to $to_version"
      return 1
    fi
    
    migration_path+=("$next_migration")
    current_version="$next_version"
  done
  
  # Print migration path
  printf '%s\n' "${migration_path[@]}"
}

# Run single migration
run_migration() {
  local migration_file="$1"
  local filename=$(basename "$migration_file")
  
  if [[ ! "$filename" =~ $MIGRATION_PATTERN ]]; then
    log_error "Invalid migration filename: $filename"
    return 1
  fi
  
  local from_version="${BASH_REMATCH[1]}"
  local to_version="${BASH_REMATCH[2]}"
  
  log_info "Running migration: $from_version → $to_version"
  
  # Create backup before migration
  log_step "Creating backup..."
  make backup &>/dev/null || log_warning "Backup failed, continuing anyway"
  
  # Execute migration
  if bash "$migration_file"; then
    log_success "Migration completed: $from_version → $to_version"
    log_migration "$from_version" "$to_version" "success"
    
    # Update version
    set_version "$to_version"
    return 0
  else
    log_error "Migration failed: $from_version → $to_version"
    log_migration "$from_version" "$to_version" "failed"
    return 1
  fi
}

# Run all migrations in path
run_migrations() {
  local from_version="$1"
  local to_version="$2"
  
  log_info "Planning migration: $from_version → $to_version"
  
  # Build migration path
  local -a migration_path
  readarray -t migration_path < <(build_migration_path "$from_version" "$to_version")
  
  if [[ ${#migration_path[@]} -eq 0 ]]; then
    log_info "No migrations needed"
    return 0
  fi
  
  log_info "Migration path:"
  for migration in "${migration_path[@]}"; do
    echo "  - $(basename "$migration")"
  done
  
  # Confirm before proceeding
  if ! confirm "Proceed with migration?"; then
    log_warning "Migration cancelled"
    return 1
  fi
  
  # Run each migration
  for migration in "${migration_path[@]}"; do
    if ! run_migration "$migration"; then
      log_error "Migration failed at: $(basename "$migration")"
      log_warning "System may be in an inconsistent state"
      return 1
    fi
  done
  
  log_success "All migrations completed successfully"
  return 0
}

# Create new migration file
create_migration() {
  local from_version="$1"
  local to_version="$2"
  local description="${3:-}"
  
  # Validate versions
  if ! [[ "$from_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || \
     ! [[ "$to_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    log_error "Invalid version format. Use semantic versioning (e.g., 1.2.3)"
    return 1
  fi
  
  local migration_file="${MIGRATIONS_DIR}/${from_version}_to_${to_version}.sh"
  
  if [[ -f "$migration_file" ]]; then
    log_error "Migration already exists: $migration_file"
    return 1
  fi
  
  # Create migration template
  cat > "$migration_file" << EOF
#!/usr/bin/env bash
# Migration: ${from_version} → ${to_version}
# Description: ${description:-TODO: Add description}
# Created: $(date -u +%Y-%m-%dT%H:%M:%SZ)

set -euo pipefail

# Source common functions
source "\$(dirname "\${BASH_SOURCE[0]}")/../lib/common.sh"

log_info "Starting migration: ${from_version} → ${to_version}"

# TODO: Add migration steps here
# Examples:
# - Move configuration files
# - Update file formats
# - Install new dependencies
# - Update module configurations

# Example migration step:
# if [[ -f "\$HOME/.old_config" ]]; then
#   log_step "Moving old configuration..."
#   mv "\$HOME/.old_config" "\$HOME/.config/new_location"
# fi

log_success "Migration completed: ${from_version} → ${to_version}"
EOF
  
  chmod +x "$migration_file"
  log_success "Created migration: $migration_file"
  log_info "Edit the migration file to add your migration steps"
}

# Check if migrations are needed
check_migrations() {
  local current_version
  current_version=$(get_version)
  
  local latest_version="$current_version"
  
  # Find the highest version we can migrate to
  for migration in "$MIGRATIONS_DIR"/*.sh; do
    [[ -f "$migration" ]] || continue
    
    local filename=$(basename "$migration")
    if [[ "$filename" =~ $MIGRATION_PATTERN ]]; then
      local mig_to="${BASH_REMATCH[2]}"
      
      if compare_versions "$mig_to" "$latest_version" &>/dev/null; then
        [[ $? -eq 1 ]] && latest_version="$mig_to"
      fi
    fi
  done
  
  if [[ "$current_version" != "$latest_version" ]]; then
    log_warning "Migrations available: $current_version → $latest_version"
    return 0
  else
    log_info "No migrations available"
    return 1
  fi
}

# List migration history
list_migration_history() {
  if [[ ! -f "$MIGRATION_LOG" ]]; then
    log_info "No migration history found"
    return
  fi
  
  log_info "Migration history:"
  echo ""
  printf "%-20s %-15s %-15s %-10s\n" "Timestamp" "From" "To" "Status"
  printf "%-20s %-15s %-15s %-10s\n" "---------" "----" "--" "------"
  
  tail -20 "$MIGRATION_LOG" | while IFS='|' read -r timestamp from to status; do
    printf "%-20s %-15s %-15s %-10s\n" \
      "$(date -d "$timestamp" +"%Y-%m-%d %H:%M" 2>/dev/null || echo "$timestamp")" \
      "$from" "$to" "$status"
  done
}

# Main command handler
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  case "${1:-check}" in
    run)
      from_version="${2:-$(get_version)}"
      to_version="${3:?Target version required}"
      run_migrations "$from_version" "$to_version"
      ;;
    create)
      create_migration "${2:?From version required}" "${3:?To version required}" "${4:-}"
      ;;
    check)
      check_migrations
      ;;
    history)
      list_migration_history
      ;;
    *)
      log_error "Unknown command: $1"
      echo "Usage: $0 {run|create|check|history}"
      exit 1
      ;;
  esac
fi