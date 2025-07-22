# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Essential Commands

### Development Commands

- `make help` - Display all available make targets
- `make install` - Full dotfiles installation
- `make install-<module>` - Install specific module (e.g., `make install-nvim`, `make install-shell`)
- `make update` - Pull latest changes and reinstall
- `make lint` - Validate all shell scripts with shellcheck
- `make test` - Run test suite
- `make check` - Verify system dependencies
- `make backup` - Create timestamped backup before major changes
- `make restore` - Restore from latest backup

### Running a Single Test
```bash
# Run specific test file
./tests/run.sh tests/unit/shell_test.sh

# Run tests for specific module
./tests/run.sh tests/integration/<module>_test.sh
```

## Architecture Overview

This dotfiles repository follows a modular architecture where each component can be installed and maintained independently. The system is designed for cross-platform compatibility (macOS/Linux) with platform-specific configurations.

### Core Components

1. **Shell Environment** (`shell/`)
   - `init.sh` - Main entry point that sources all shell configurations
   - `exports.sh` - PATH and environment variables (currently being edited)
   - `aliases.sh` - Command aliases
   - `functions.sh` - Shell functions
   - `tools.sh` - External tool configurations
   - Platform-specific configs in `bash/` and `zsh/`

2. **Language Environments** (`langs/`)
   - Each language has its own `setup.sh` script
   - Uses ASDF for version management
   - Languages: elixir, go, java, javascript, lua, shell, make, docker, python, ruby, rust, terraform, typescript, etc.

3. **Symlink Management** (`symlinks/`)
   - Uses Dotbot for managing symlinks
   - Configuration files: `conf.yaml` (base), `conf.macos.yaml`, `conf.linux.yaml`
   - Platform detection handled automatically

4. **Common Library** (`lib/common.sh`)
   - Provides utilities for all scripts:
     - Colored output functions: `success()`, `info()`, `warning()`, `error()`
     - Symlink creation with backup: `safe_link()`
     - Platform detection: `is_macos()`, `is_linux()`
     - Directory management: `ensure_dir()`

### Module System

Each module (editors, terminal, shell, etc.) follows this pattern:
- Has its own directory with configuration files
- Contains a `setup.sh` script for installation
- Can be installed independently via `make install-<module>`
- Dependencies managed through the common library

Editors include:
  - `nvim/` - Neovim configuration
  - `vscode/` - Visual Studio Code configuration
  - `cursor/` - Cursor editor configuration
  - `windsurf/` - WindSurf editor configuration

Terminals include:
  - `alacritty/` - Alacritty terminal configuration
  - `warp/` - Warp terminal configuration
  - `kitty/` - Kitty terminal configuration
  - `iterm2/` - iTerm2 terminal configuration

### Critical Implementation Details

1. **Shell Initialization Flow**:
   - `.zshrc` or `.bashrc` sources `shell/init.sh` (I am a Zsh user)
   - `init.sh` sources exports, aliases, functions, tools in order
   - Platform-specific files loaded based on OS detection

2. **Path Management**:
   - Custom paths added in `shell/exports.sh`
   - Language-specific paths managed by ASDF
   - Local bin directory: `$HOME/.dotfiles/bin`

3. **Error Handling**:
   - All scripts use `set -euo pipefail` for safety
   - Common library provides consistent error reporting
   - Backup system prevents data loss during installation

### Current Migration Project

The repository is undergoing a "SuperClaude" migration with 68 planned tasks across 18 phases. Key goals include:
- Enhanced modularity and testing
- AI/MCP integration capabilities
- Performance optimization
- Improved documentation

When implementing new features, consider:
- Maintaining backward compatibility
- Following the existing module pattern
- Using the common library for consistency
- Adding appropriate tests
