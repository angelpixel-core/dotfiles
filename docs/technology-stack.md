# Technology Stack (Dotfiles Core)

| Category | Technology | Version/Signal | Evidence |
|---|---|---|---|
| Shell runtime | Zsh/Bash | active configs | `shell/zsh/.zshrc`, `shell/bash/.bashrc` |
| Build/orchestration | GNU Make | root orchestrator | `Makefile` |
| Scripting | Bash/Zsh | operational scripts | `lib/*.sh`, `langs/*/setup.sh`, `scripts/bootstrap/*.sh` |
| Symlink management | YAML declarative maps + shell runtime | active | `symlinks/conf*.yaml`, `scripts/bootstrap/install.sh` |
| Version mgmt | asdf + `.tool-versions` | active | `.tool-versions`, `shell/exports.sh` |
| Editor module | Neovim (submodule) | tracked as gitlink | `.gitmodules`, `editors/nvim` |
| AI tooling bundle | TypeScript/Bun (vendored tool) | package signal present | `ai-toolings/open-code/oh-my-opencode/package.json` |
| OS domains | macOS/Linux | modular folders | `os/mac`, `os/linux` |

Observation:
- Core repo behaves as operational CLI/system-config monolith with modular domains rather than a deployable app split.
