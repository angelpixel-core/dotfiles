# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Common commands

Use make help to list available tasks:

- Help and discovery
  - make help — list available targets
  - make list — list modules discovered under config/
  - make status — show installation status (invokes bin/dotfiles status; if bin/dotfiles is absent this will error)

- Install and update
  - make install — full install (calls bootstrap/install.sh; if missing, this will error)
  - make install-<module> — install a single module (e.g., make install-nvim)
  - make update — git pull --rebase then re-run install

- Backup and cleanup
  - make backup — backup current configs to ~/.dotfiles.backup/<timestamp>
  - make restore — restore most recent backup
  - make clean — remove broken symlinks under $HOME

- Lint and checks
  - make lint — run shellcheck across *.sh scripts
    - macOS prerequisite: brew install shellcheck
  - make check — dependency checks (calls bootstrap/check-deps.sh; may be missing)

- Tests
  - make test — runs tests via tests/run.sh
    - Note: tests/ is not present in this snapshot. If tests/run.sh is absent this target will fail. No single-test runner is defined in Makefile.

- Versioning and migrations
  - make version — print current version (reads VERSION)
  - make version-info — detailed version info and module versions
  - make version-bump TYPE=patch|minor|major — bump semantic version
  - make version-check — verify version integrity
  - make version-lock — write .version.lock snapshot of current/module versions
  - make migrate — check for pending migrations
  - make migrate-run TO=x.y.z — migrate from current to target version
  - make migrate-history — show recent migration history

## High-level architecture

This repo is a modular dotfiles system orchestrated by a Makefile, with versioning and migrations in lib/, symlink mapping in symlinks/, and configuration modules for shell, editor, terminal, window management, and OS-specific tweaks.

- Orchestration (Makefile)
  - Central entrypoint for install, update, backup/restore, lint, tests, versioning, and migrations.
  - Several targets call scripts under bootstrap/ and tests/ that may not exist in this snapshot. If absent, the target will fail; create the script or adjust the Makefile before relying on it.

- Core libraries (lib/)
  - lib/common.sh — shared utilities used across scripts
    - Defines DOTFILES_ROOT resolution, colored logging (log_info/success/warning/error), confirm prompts, create_symlink with backup, and error traps.
  - lib/version.sh — semantic version management
    - get/set, bump major|minor|patch, module version get/set, verify, lock snapshot, and pretty info printing.
  - lib/migration.sh — ordered migration runner
    - Plans migration paths between VERSION values using migrations/*.sh, performs backups, logs to .migration.log, and updates VERSION on success. Includes helpers to create new migration templates and view history.

- Migrations (migrations/)
  - Versioned scripts (e.g., 0.0.0_to_0.1.0.sh, 0.1.0_to_0.2.0.sh) use lib/common.sh and lib/version.sh to evolve structure and module versions.

- Symlink mapping (symlinks/)
  - YAML-driven mapping (conf.yaml plus OS-specific overrides) describing files to create/link into $HOME.
  - Example: links ~/.zshrc to shell/zsh/.zshrc and creates ~/.hushlogin on macOS.
  - The actual linking tool is not present in this snapshot; it’s typically invoked by the install flow.

- Shell configuration (shell/)
  - Entry: shell/init.sh sources:
    - exports.sh — sets PATH layering, editor, LLM-related environment, and other tool env vars.
      - Important: This file defines API keys and cloud credentials as environment variables. Treat them as secrets; do not print their values in logs or output.
    - aliases.sh — navigation/git/editor/process helpers (e.g., n() wrapper to open files at line/col in Neovim).
    - tools.sh — initializes asdf, thefuck, zoxide, fzf theme/bindings, eza aliases, RBEnv, and utility functions; also starts yabai and skhd services on macOS if installed.
    - functions.sh — small helpers for auth and 1Password.
  - Zsh entrypoint: shell/zsh/.zshrc sets DOTFILES_ROOT, initializes Zim, and sources shell/init.sh.

- Editor (editors/nvim/)
  - init.lua requires angel.core and angel.lazy (lazy.nvim). Core configuration lives in lua/angel/core (options, keymaps).
  - Example plugin config in lua/angel/plugins (e.g., lualine.lua). lazy-lock.json pins plugin versions.

- Terminal (terminal/)
  - alacritty/alacritty.toml — theme import, font, opacity, padding, and TERM settings.
  - tmux/tmux.conf — custom prefix (Ctrl-a), pane management, mouse, scrollback, and TPM plugins (ensure ~/.tmux/plugins/tpm is installed/initialized).

- Window management and shortcuts (macOS)
  - tiling-windows-manager/yabai/yabairc — bsp layout, gaps/padding, mouse actions, and app rules.
  - shortcuts/skhd/skhdrc — window focus/move/swap/resize bindings aligned with yabai.
  - menu-bar/sketchybar — bar appearance, colors, and items sourced from items/ and plugins/.

- OS-specific (
  - os/mac/mac_configs.sh — example defaults tweak (e.g., disable .DS_Store on network volumes).

- Git configuration (git/.gitconfig)
  - Sets editor to nvim, delta as pager, aliases, default main branch, LFS filters, and rebase-on-pull.

## Important docs and rules in-repo

- project_docs/README.md (highlights)
  - Install: make install (or module-specific e.g., make install-nvim, make install-tmux)
  - Lint/Check/Tests: make lint, make check, make test (tests/ may be absent here)

- .claude/ (BMAD commands and agent rules)
  - The bmad-master agent (see .claude/commands/BMad/agents/bmad-master.md) includes critical operating rules that matter when driving automated workflows:
    - Load resources on demand; do not pre-scan filesystem at startup.
    - Commands are invoked with a * prefix (e.g., *help); present numbered option lists for choices.
    - When executing formal task workflows, their instructions override base constraints; tasks with elicit=true require interactive steps.

## Notes for running in Warp

- This repo is shell-heavy. Many targets depend on external tools (e.g., shellcheck, yabai, skhd, fzf, asdf, rbenv, TPM). Prefer checking existence before invoking and surface actionable install commands when absent.
- Secrets: Environment variables for APIs/cloud services are defined in shell/exports.sh. Assume they are present in the running shell; avoid echoing or logging their values.
