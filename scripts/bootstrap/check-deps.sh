#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# shellcheck source=lib/common.sh
source "$DOTFILES_ROOT/lib/common.sh"

required_cmds=(git bash make awk sed find ln)
optional_cmds=(shellcheck)

missing=()

log_info "Verificando dependencias requeridas..."
for cmd in "${required_cmds[@]}"; do
  if command_exists "$cmd"; then
    log_success "OK: $cmd"
  else
    log_error "Falta comando requerido: $cmd"
    missing+=("$cmd")
  fi
done

log_info "Verificando dependencias opcionales..."
for cmd in "${optional_cmds[@]}"; do
  if command_exists "$cmd"; then
    log_success "OK (opcional): $cmd"
  else
    log_warning "Opcional no instalado: $cmd"
  fi
done

if (( ${#missing[@]} > 0 )); then
  log_error "Dependencias faltantes: ${missing[*]}"
  exit 1
fi

log_success "Dependencias requeridas completas"
