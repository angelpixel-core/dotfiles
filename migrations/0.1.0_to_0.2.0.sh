#!/usr/bin/env bash
# Migration: 0.1.0 → 0.2.0
# Description: Add neovim module support
# Created: 2024-01-20T10:00:00Z

set -euo pipefail

# Source common functions
source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"

log_info "Starting migration: 0.1.0 → 0.2.0"
log_info "Adding neovim module support"

# Add neovim module version
log_step "Adding neovim module to version tracking..."

# Set neovim version to 0.10.3 as specified
"$DOTFILES_ROOT/lib/version.sh" module set nvim 0.10.3
log_success "Neovim module added with version: 0.10.3"

# Ensure neovim config directory exists
log_step "Checking neovim configuration..."
if [[ -d "$DOTFILES_ROOT/nvim" ]] || [[ -d "$DOTFILES_ROOT/config/nvim" ]]; then
  log_success "Neovim configuration directory found"
else
  ensure_dir "$DOTFILES_ROOT/config/nvim"
  log_success "Created neovim configuration directory"
fi

# Update version lock
log_step "Updating version lock..."
"$DOTFILES_ROOT/lib/version.sh" lock

log_success "Migration completed: 0.1.0 → 0.2.0"
log_info "Neovim (0.10.3) has been added to version tracking"