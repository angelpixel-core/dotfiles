#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

if command -v gitleaks >/dev/null 2>&1; then
  echo "[security] Running gitleaks..."
  exec gitleaks detect --source "$DOTFILES_ROOT" --redact --no-banner
fi

echo "[security] gitleaks not installed, running fallback high-signal scan..."
if rg -n --hidden --glob '!.git/**' --glob '!ai-toolings/**' --glob '!editors/nvim/**' \
  'AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{20,}|xox[baprs]-|BEGIN [A-Z ]*PRIVATE KEY|AIza[0-9A-Za-z_-]{35}|mxb_[A-Za-z0-9]{20,}' \
  "$DOTFILES_ROOT"; then
  echo "[security] Potential secrets detected by fallback scan"
  exit 1
fi

echo "[security] No high-signal leaks detected by fallback scan"
