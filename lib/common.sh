#!/usr/bin/env bash
# lib/common.sh - Funciones comunes para todos los scripts

set -euo pipefail

# Variables globales
readonly DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly DOTFILES_LIB="${DOTFILES_ROOT}/lib"
readonly DOTFILES_CONFIG="${DOTFILES_ROOT}/config"

# Colores ANSI
readonly COLOR_RESET='\033[0m'
readonly COLOR_BOLD='\033[1m'
readonly COLOR_RED='\033[31m'
readonly COLOR_GREEN='\033[32m'
readonly COLOR_YELLOW='\033[33m'
readonly COLOR_BLUE='\033[34m'
readonly COLOR_MAGENTA='\033[35m'
readonly COLOR_CYAN='\033[36m'

# Iconos Unicode
readonly ICON_SUCCESS="✓"
readonly ICON_ERROR="✗"
readonly ICON_WARNING="⚠"
readonly ICON_INFO="ℹ"
readonly ICON_ARROW="→"

# Detectar si soporta colores
if [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
  readonly SUPPORTS_COLOR=true
else
  readonly SUPPORTS_COLOR=false
fi

# Función para imprimir con color
print_color() {
  local color="$1"
  shift
  if [[ "$SUPPORTS_COLOR" == true ]]; then
    printf "%b%s%b\n" "$color" "$*" "$COLOR_RESET"
  else
    printf "%s\n" "$*"
  fi
}

# Funciones de logging
log_info() {
  print_color "$COLOR_BLUE" "$ICON_INFO $*"
}

log_success() {
  print_color "$COLOR_GREEN" "$ICON_SUCCESS $*"
}

log_warning() {
  print_color "$COLOR_YELLOW" "$ICON_WARNING $*"
}

log_error() {
  print_color "$COLOR_RED" "$ICON_ERROR $*" >&2
}

log_step() {
  print_color "$COLOR_CYAN" "$ICON_ARROW $*"
}

# Función para confirmar acciones
confirm() {
  local prompt="${1:-¿Continuar?}"
  local default="${2:-n}"
  
  local choices="[y/N]"
  [[ "$default" == "y" ]] && choices="[Y/n]"
  
  read -r -p "$prompt $choices " response
  response="${response:-$default}"
  
  [[ "$response" =~ ^[Yy]$ ]]
}

# Verificar si un comando existe
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Crear directorio si no existe
ensure_dir() {
  local dir="$1"
  if [[ ! -d "$dir" ]]; then
    log_step "Creando directorio: $dir"
    mkdir -p "$dir"
  fi
}

# Backup de archivo/directorio
backup_item() {
  local item="$1"
  local backup_dir="${2:-$HOME/.dotfiles.backup}"
  
  if [[ -e "$item" ]] && [[ ! -L "$item" ]]; then
    ensure_dir "$backup_dir"
    local basename="$(basename "$item")"
    local backup_path="$backup_dir/${basename}.$(date +%Y%m%d_%H%M%S)"
    
    log_step "Backup: $item → $backup_path"
    mv "$item" "$backup_path"
  fi
}

# Crear enlace simbólico con backup
create_symlink() {
  local source="$1"
  local target="$2"
  
  # Verificar que source existe
  if [[ ! -e "$source" ]]; then
    log_error "Source no existe: $source"
    return 1
  fi
  
  # Si target existe y no es un symlink, hacer backup
  if [[ -e "$target" ]] && [[ ! -L "$target" ]]; then
    backup_item "$target"
  fi
  
  # Eliminar symlink existente si apunta a otro lugar
  if [[ -L "$target" ]]; then
    local current_source="$(readlink "$target")"
    if [[ "$current_source" != "$source" ]]; then
      log_step "Actualizando symlink: $target"
      rm -f "$target"
    else
      return 0  # Ya existe y es correcto
    fi
  fi
  
  # Crear directorio padre si no existe
  ensure_dir "$(dirname "$target")"
  
  # Crear symlink
  ln -sf "$source" "$target"
  log_success "Symlink creado: $target → $source"
}

# Ejecutar comando con manejo de errores
run_command() {
  local cmd="$1"
  local error_msg="${2:-Error ejecutando comando}"
  
  if ! eval "$cmd"; then
    log_error "$error_msg: $cmd"
    return 1
  fi
}

# Cargar archivo si existe
source_if_exists() {
  local file="$1"
  [[ -f "$file" ]] && source "$file"
}

# Obtener respuesta del usuario
get_input() {
  local prompt="$1"
  local default="$2"
  local response
  
  if [[ -n "$default" ]]; then
    read -r -p "$prompt [$default]: " response
    echo "${response:-$default}"
  else
    read -r -p "$prompt: " response
    echo "$response"
  fi
}

# Verificar versión mínima de bash
check_bash_version() {
  local required="${1:-4.0}"
  local current="${BASH_VERSION%%[^0-9.]*}"
  
  if [[ "$(printf '%s\n' "$required" "$current" | sort -V | head -n1)" != "$required" ]]; then
    log_error "Bash $required o superior requerido (actual: $current)"
    return 1
  fi
}

# Trap para limpiar en caso de error
cleanup_on_error() {
  local exit_code=$?
  if [[ $exit_code -ne 0 ]]; then
    log_error "Script terminado con error (código: $exit_code)"
  fi
}

# Configurar traps
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  trap cleanup_on_error EXIT
fi
