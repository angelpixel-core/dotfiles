#!/usr/bin/env bash
# Migration: 0.0.0 → 0.1.0
# Description: Initial dotfiles setup with shell (zsh) support
# Created: 2024-01-20T09:00:00Z

set -euo pipefail

# Source common functions
source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"

log_info "Starting migration: 0.0.0 → 0.1.0"
log_info "Initial dotfiles setup with shell support"

# Create module versions directory
log_step "Creating module versions directory..."
ensure_dir "$DOTFILES_ROOT/.versions"

# Initialize shell module version
log_step "Initializing shell (zsh) module..."

# Set shell version to 5.9.0 as specified
"$DOTFILES_ROOT/lib/version.sh" module set shell 5.9.0
log_success "Shell (zsh) module initialized with version: 5.9.0"

# Create initial directory structure
log_step "Ensuring core directories exist..."
ensure_dir "$DOTFILES_ROOT/bin"
ensure_dir "$DOTFILES_ROOT/config"
ensure_dir "$DOTFILES_ROOT/lib"
ensure_dir "$DOTFILES_ROOT/shell"

# Create initial version lock
log_step "Creating initial version lock..."
"$DOTFILES_ROOT/lib/version.sh" lock

log_success "Migration completed: 0.0.0 → 0.1.0"
log_info "Dotfiles initialized with shell (zsh 5.9.0) support"