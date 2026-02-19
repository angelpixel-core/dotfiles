# Architecture Patterns

Primary pattern:
- **Layered operations architecture**
  - Interface layer: shell entrypoints (`.zshrc`, `.bashrc`) and Make targets
  - Orchestration layer: `shell/init.sh`, `Makefile`, `scripts/bootstrap/*`
  - Capability modules: `langs/`, `terminal/`, `os/`, `caps-layout/`, `shorcuts/`
  - Shared utilities: `lib/*.sh`

Secondary pattern:
- **Plugin/submodule composition**
  - External components integrated as submodules (`terminal/wezterm`, `shell/functions/system-monitor`, `editors/nvim`, `.zim modules`)

Risk pattern detected:
- **Mixed source-of-truth** between submodule pointers, vendored content, and generated artifacts tracked in-repo.
