#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# shellcheck source=lib/common.sh
source "$DOTFILES_ROOT/lib/common.sh"

backup_dir="${1:-}"
if [[ -z "$backup_dir" || ! -d "$backup_dir" ]]; then
  log_error "Uso: $0 <backup_dir_existente>"
  exit 1
fi

log_info "Restaurando desde: $backup_dir"

while IFS= read -r src; do
  rel="${src#$backup_dir/}"
  target="$HOME/$rel"

  if [[ -e "$target" || -L "$target" ]]; then
    ts="$(date +%Y%m%d_%H%M%S)"
    archive_target="$target.before_restore.$ts"
    mv "$target" "$archive_target"
    log_warning "Archivo existente archivado: $archive_target"
  fi

  mkdir -p "$(dirname "$target")"
  cp -a "$src" "$target"
  log_success "Restaurado: $target"
done < <(find "$backup_dir" -mindepth 1 -type f -o -type l)

log_success "Restore completado"
