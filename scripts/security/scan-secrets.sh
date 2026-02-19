#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

if command -v gitleaks >/dev/null 2>&1; then
  echo "[security] Running gitleaks..."
  exec gitleaks detect --source "$DOTFILES_ROOT" --redact --no-banner
fi

echo "[security] gitleaks not installed, running fallback grep scan..."
rg -n --hidden --glob '!.git/**' --glob '!ai-toolings/**' --glob '!editors/nvim/**' \
  'AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{20,}|xox[baprs]-|BEGIN [A-Z ]*PRIVATE KEY|api[_-]?key|secret|token' \
  "$DOTFILES_ROOT"
