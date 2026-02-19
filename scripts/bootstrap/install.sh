#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# shellcheck source=scripts/bootstrap/lib.sh
source "$DOTFILES_ROOT/scripts/bootstrap/lib.sh"

module=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --module)
      [[ $# -lt 2 ]] && { log_error "Falta valor para --module"; exit 1; }
      module="$2"
      shift 2
      ;;
    *)
      log_error "Argumento no soportado: $1"
      exit 1
      ;;
  esac
done

log_info "Instalando dotfiles..."

common_conf="$DOTFILES_ROOT/symlinks/conf.yaml"
os_conf=""
if os_conf="$(resolve_os_symlink_config)"; then
  :
else
  log_warning "No hay configuración específica para $(uname -s)"
fi

case "$module" in
  "")
    apply_links_from_yaml "$common_conf"
    [[ -n "$os_conf" ]] && apply_links_from_yaml "$os_conf"
    ;;
  shell|common)
    apply_links_from_yaml "$common_conf"
    ;;
  macos)
    apply_links_from_yaml "$DOTFILES_ROOT/symlinks/conf.macos.yaml"
    ;;
  macos-intel)
    apply_links_from_yaml "$DOTFILES_ROOT/symlinks/conf.macos-intel.yaml"
    ;;
  linux)
    apply_links_from_yaml "$DOTFILES_ROOT/symlinks/conf.linux.yaml"
    ;;
  *)
    log_error "Módulo no soportado: $module"
    log_info "Módulos soportados: shell, common, macos, macos-intel, linux"
    exit 1
    ;;
esac

log_success "Instalación finalizada"
