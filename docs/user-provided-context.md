# User-Provided Context (Deep Scan)

Goal:
- End-to-end audit of dotfiles repository and phased normalization plan.

Priorities:
1. Maintainability
2. Reproducibility
3. Speed

Platforms:
- ZSH on macOS (Apple Silicon) first
- Linux mirrored afterward

Constraints:
- No deletion without explicit confirmation
- If uncertain, move to `archive/`

Required:
- Detect leaks
- Propose secrets strategy with environment normalization + 1Password
- Submodules allowed
- Vendor allowed if orderly and documented

Critical focus:
- Fix `git submodule status` failure due to missing mapping in `.gitmodules` for `.zim/modules/completion`
- Fix broken Makefile references to non-existent `bootstrap/*`

Deliverables:
1. Repo map + real entrypoints
2. Findings by severity
3. Uniform target modular structure (including `shorcuts` -> `shortcuts`)
4. Reversible phased migration roadmap + smoke tests
5. Executable atomic backlog (origin -> destination)
