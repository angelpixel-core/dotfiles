#!/usr/bin/env bash
# lib/version.sh - Version management system for dotfiles

set -euo pipefail

# Source common functions
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

# Version constants
[[ -z "${VERSION_FILE:-}" ]] && readonly VERSION_FILE="${DOTFILES_ROOT}/VERSION"
[[ -z "${VERSION_LOCK_FILE:-}" ]] && readonly VERSION_LOCK_FILE="${DOTFILES_ROOT}/.version.lock"
[[ -z "${MIGRATIONS_DIR:-}" ]] && readonly MIGRATIONS_DIR="${DOTFILES_ROOT}/migrations"
[[ -z "${MODULE_VERSION_DIR:-}" ]] && readonly MODULE_VERSION_DIR="${DOTFILES_ROOT}/.versions"

# Semantic versioning regex
[[ -z "${SEMVER_REGEX:-}" ]] && readonly SEMVER_REGEX="^([0-9]+)\.([0-9]+)\.([0-9]+)(-([0-9A-Za-z-]+))?(\+([0-9A-Za-z-]+))?$"

# Get current dotfiles version
get_version() {
  if [[ -f "$VERSION_FILE" ]]; then
    cat "$VERSION_FILE"
  else
    echo "0.0.0"
  fi
}

# Parse semantic version into components
parse_version() {
  local version="$1"
  
  if [[ ! "$version" =~ $SEMVER_REGEX ]]; then
    log_error "Invalid version format: $version"
    return 1
  fi
  
  echo "MAJOR=${BASH_REMATCH[1]}"
  echo "MINOR=${BASH_REMATCH[2]}"
  echo "PATCH=${BASH_REMATCH[3]}"
  echo "PRERELEASE=${BASH_REMATCH[5]:-}"
  echo "BUILD=${BASH_REMATCH[7]:-}"
}

# Compare two versions (returns: 0=equal, 1=first>second, 2=first<second)
compare_versions() {
  local version1="$1"
  local version2="$2"
  
  # Parse versions
  local v1_parts v2_parts
  v1_parts=($(parse_version "$version1" | cut -d= -f2))
  v2_parts=($(parse_version "$version2" | cut -d= -f2))
  
  # Compare major.minor.patch
  for i in 0 1 2; do
    if ((${v1_parts[i]} > ${v2_parts[i]})); then
      return 1
    elif ((${v1_parts[i]} < ${v2_parts[i]})); then
      return 2
    fi
  done
  
  return 0
}

# Bump version (major, minor, patch)
bump_version() {
  local bump_type="${1:-patch}"
  local current_version
  current_version=$(get_version)
  
  # Parse current version
  eval "$(parse_version "$current_version")"
  
  case "$bump_type" in
    major)
      MAJOR=$((MAJOR + 1))
      MINOR=0
      PATCH=0
      ;;
    minor)
      MINOR=$((MINOR + 1))
      PATCH=0
      ;;
    patch)
      PATCH=$((PATCH + 1))
      ;;
    *)
      log_error "Invalid bump type: $bump_type"
      return 1
      ;;
  esac
  
  local new_version="${MAJOR}.${MINOR}.${PATCH}"
  echo "$new_version"
}

# Set new version
set_version() {
  local new_version="$1"
  
  # Validate version format
  if [[ ! "$new_version" =~ $SEMVER_REGEX ]]; then
    log_error "Invalid version format: $new_version"
    return 1
  fi
  
  # Create backup of current version
  if [[ -f "$VERSION_FILE" ]]; then
    cp "$VERSION_FILE" "${VERSION_FILE}.bak"
  fi
  
  # Write new version
  echo "$new_version" > "$VERSION_FILE"
  log_success "Version updated to: $new_version"
}

# Get module version
get_module_version() {
  local module="$1"
  local version_file="${MODULE_VERSION_DIR}/${module}.version"
  
  if [[ -f "$version_file" ]]; then
    cat "$version_file"
  else
    echo "0.0.0"
  fi
}

# Set module version
set_module_version() {
  local module="$1"
  local version="$2"
  
  ensure_dir "$MODULE_VERSION_DIR"
  echo "$version" > "${MODULE_VERSION_DIR}/${module}.version"
  log_success "Module '$module' version set to: $version"
}

# Check version compatibility
check_compatibility() {
  local required_version="$1"
  local current_version
  current_version=$(get_version)
  
  if compare_versions "$current_version" "$required_version"; then
    local result=$?
    if [[ $result -eq 2 ]]; then
      log_warning "Current version ($current_version) is older than required ($required_version)"
      return 1
    fi
  fi
  
  return 0
}

# List all module versions
list_module_versions() {
  log_info "Module versions:"
  
  if [[ -d "$MODULE_VERSION_DIR" ]]; then
    for version_file in "$MODULE_VERSION_DIR"/*.version; do
      if [[ -f "$version_file" ]]; then
        local module=$(basename "$version_file" .version)
        local version=$(cat "$version_file")
        printf "  %-20s %s\n" "$module:" "$version"
      fi
    done
  else
    log_warning "No module versions found"
  fi
}

# Create version lock file
create_version_lock() {
  local lock_data="{
  \"dotfiles_version\": \"$(get_version)\",
  \"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",
  \"modules\": {"
  
  if [[ -d "$MODULE_VERSION_DIR" ]]; then
    local first=true
    for version_file in "$MODULE_VERSION_DIR"/*.version; do
      if [[ -f "$version_file" ]]; then
        local module=$(basename "$version_file" .version)
        local version=$(cat "$version_file")
        
        if [[ "$first" != true ]]; then
          lock_data+=","
        fi
        lock_data+="
    \"$module\": \"$version\""
        first=false
      fi
    done
  fi
  
  lock_data+="
  }
}"
  
  echo "$lock_data" > "$VERSION_LOCK_FILE"
  log_success "Version lock file created: $VERSION_LOCK_FILE"
}

# Verify version integrity
verify_versions() {
  log_info "Verifying version integrity..."
  
  local has_errors=false
  
  # Check main version file
  if [[ ! -f "$VERSION_FILE" ]]; then
    log_error "VERSION file not found"
    has_errors=true
  else
    local version
    version=$(get_version)
    if [[ ! "$version" =~ $SEMVER_REGEX ]]; then
      log_error "Invalid main version format: $version"
      has_errors=true
    else
      log_success "Main version valid: $version"
    fi
  fi
  
  # Check module versions
  if [[ -d "$MODULE_VERSION_DIR" ]]; then
    for version_file in "$MODULE_VERSION_DIR"/*.version; do
      if [[ -f "$version_file" ]]; then
        local module=$(basename "$version_file" .version)
        local version=$(cat "$version_file")
        
        if [[ ! "$version" =~ $SEMVER_REGEX ]]; then
          log_error "Invalid version for module '$module': $version"
          has_errors=true
        else
          log_success "Module '$module' version valid: $version"
        fi
      fi
    done
  fi
  
  if [[ "$has_errors" == true ]]; then
    return 1
  fi
  
  log_success "All versions valid"
  return 0
}

# Print version info
print_version_info() {
  local current_version
  current_version=$(get_version)
  
  echo "Dotfiles Version Management"
  echo "=========================="
  echo "Current version: $current_version"
  echo ""
  
  # Parse and display version components
  eval "$(parse_version "$current_version")"
  echo "Components:"
  echo "  Major: $MAJOR"
  echo "  Minor: $MINOR"
  echo "  Patch: $PATCH"
  [[ -n "$PRERELEASE" ]] && echo "  Pre-release: $PRERELEASE"
  [[ -n "$BUILD" ]] && echo "  Build: $BUILD"
  echo ""
  
  # Show module versions if any
  if [[ -d "$MODULE_VERSION_DIR" ]] && ls "$MODULE_VERSION_DIR"/*.version &>/dev/null; then
    list_module_versions
  fi
}

# Main command handler
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  case "${1:-info}" in
    info)
      print_version_info
      ;;
    get)
      get_version
      ;;
    set)
      set_version "${2:?Version required}"
      ;;
    bump)
      new_version=$(bump_version "${2:-patch}")
      set_version "$new_version"
      ;;
    module)
      case "${2:-list}" in
        get)
          get_module_version "${3:?Module name required}"
          ;;
        set)
          set_module_version "${3:?Module name required}" "${4:?Version required}"
          ;;
        list)
          list_module_versions
          ;;
        *)
          log_error "Unknown module command: $2"
          exit 1
          ;;
      esac
      ;;
    check)
      check_compatibility "${2:?Required version needed}"
      ;;
    lock)
      create_version_lock
      ;;
    verify)
      verify_versions
      ;;
    *)
      log_error "Unknown command: $1"
      echo "Usage: $0 {info|get|set|bump|module|check|lock|verify}"
      exit 1
      ;;
  esac
fi