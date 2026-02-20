#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# shellcheck disable=SC1091
source "$DOTFILES_ROOT/lib/common.sh"

expand_home_path() {
  local path="$1"
  if [[ "$path" == "~" ]]; then
    echo "$HOME"
  elif [[ "$path" == \~/* ]]; then
    echo "$HOME/${path#\~/}"
  else
    echo "$path"
  fi
}

normalize_source_path() {
  local source_path
  source_path="$(expand_home_path "$1")"

  if [[ "$source_path" == /* ]]; then
    echo "$source_path"
  else
    echo "$DOTFILES_ROOT/$source_path"
  fi
}

normalize_target_path() {
  expand_home_path "$1"
}

list_link_pairs_from_yaml() {
  local yaml_file="$1"

  awk '
    /^- link:/ { in_link = 1; next }
    in_link && /^- / { in_link = 0 }
    in_link && /^[[:space:]]+[^#[:space:]][^:]*:[[:space:]]*/ {
      line = $0
      sub(/^[[:space:]]+/, "", line)
      key = line
      sub(/:.*/, "", key)
      val = line
      sub(/^[^:]+:[[:space:]]*/, "", val)
      gsub(/[[:space:]]+$/, "", key)
      gsub(/[[:space:]]+$/, "", val)
      print key "|" val
    }
  ' "$yaml_file"
}

apply_links_from_yaml() {
  local yaml_file="$1"
  local pair target_raw source_raw target source_path

  if [[ ! -f "$yaml_file" ]]; then
    log_warning "No existe configuración de symlinks: $yaml_file"
    return 0
  fi

  while IFS= read -r pair; do
    [[ -z "$pair" ]] && continue
    target_raw="${pair%%|*}"
    source_raw="${pair#*|}"

    target="$(normalize_target_path "$target_raw")"
    source_path="$(normalize_source_path "$source_raw")"

    if [[ ! -e "$source_path" ]]; then
      log_warning "Saltando symlink. Source inexistente: $source_path"
      continue
    fi

    create_symlink "$source_path" "$target"
  done < <(list_link_pairs_from_yaml "$yaml_file")
}

resolve_os_symlink_config() {
  local os_name arch
  os_name="$(uname -s)"
  arch="$(uname -m)"

  if [[ "$os_name" == "Darwin" ]]; then
    if [[ "$arch" == "x86_64" ]]; then
      echo "$DOTFILES_ROOT/symlinks/conf.macos-intel.yaml"
    else
      echo "$DOTFILES_ROOT/symlinks/conf.macos.yaml"
    fi
    return 0
  fi

  if [[ "$os_name" == "Linux" ]]; then
    echo "$DOTFILES_ROOT/symlinks/conf.linux.yaml"
    return 0
  fi

  return 1
}
