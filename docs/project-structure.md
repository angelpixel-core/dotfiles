# Project Structure Classification

- **Project Root:** `/Users/angel.szymczak/Vaults/Dotfiles`
- **Repository Type:** `monolith` (dotfiles modular monorepo-style folders, single operational root)
- **Parts Count:** `1`
- **Primary Classification (documentation-requirements.csv):** `cli`
- **Secondary Traits:** `infra` (IaC-like shell/bootstrap concerns), `library` (shared shell/libs)

## Classification Summary

This repository behaves as a **single-part operational CLI/system configuration codebase**:

- Orchestration lives in shell and Make targets (`shell/init.sh`, `Makefile`).
- Shared runtime logic is centralized in `lib/`, `migrations/`, `symlinks/`.
- Platform modules are organized by concern (`os/`, `terminal/`, `langs/`, `editors/`).
- There is no application split (`client/server`) or independent deployable services at root.

## Critical Structure Notes

- Embedded and declared gitlinks coexist (e.g. `editors/nvim`, `.zim` modules).
- Documentation and generated artifacts are mixed (`docs/`, `project_docs/`, `_bmad-output/`).
- Typo in top-level folder name: `shorcuts/` (target rename to `shortcuts/`).
