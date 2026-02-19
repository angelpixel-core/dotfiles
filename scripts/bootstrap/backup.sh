#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# shellcheck source=scripts/bootstrap/lib.sh
source "$DOTFILES_ROOT/scripts/bootstrap/lib.sh"

backup_dir="${1:-}"
if [[ -z "$backup_dir" ]]; then
  log_error "Uso: $0 <backup_dir>"
  exit 1
fi

mkdir -p "$backup_dir"

configs=("$DOTFILES_ROOT/symlinks/conf.yaml")
if os_conf="$(resolve_os_symlink_config)"; then
  configs+=("$os_conf")
fi

log_info "Creando backup en: $backup_dir"

for cfg in "${configs[@]}"; do
  [[ -f "$cfg" ]] || continue
  while IFS= read -r pair; do
    [[ -z "$pair" ]] && continue
    target_raw="${pair%%|*}"
    target="$(normalize_target_path "$target_raw")"

    if [[ ! -e "$target" && ! -L "$target" ]]; then
      continue
    fi

    rel_path="${target#$HOME/}"
    if [[ "$rel_path" == "$target" ]]; then
      log_warning "Target fuera de HOME, no se respalda: $target"
      continue
    fi

    dest="$backup_dir/$rel_path"
    mkdir -p "$(dirname "$dest")"
    cp -a "$target" "$dest"
    log_success "Backup: $target -> $dest"
  done < <(list_link_pairs_from_yaml "$cfg")
done

log_success "Backup completado"
