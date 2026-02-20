#!/usr/bin/env bash

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

printf "[smoke] shell syntax\n"
find "$DOTFILES_ROOT/scripts/bootstrap" -type f -name "*.sh" -print0 | xargs -0 -n1 bash -n

printf "[smoke] required bootstrap scripts\n"
for f in install.sh backup.sh restore.sh check-deps.sh; do
  test -x "$DOTFILES_ROOT/scripts/bootstrap/$f"
done

printf "[smoke] required bin commands\n"
for f in analyze_dotfiles sync_dotfiles; do
  test -x "$DOTFILES_ROOT/bin/$f"
done

printf "[smoke] bootstrap expands ~/ paths correctly\n"
expanded_home_path="$(bash -c 'source "$1"; expand_home_path "~/.zshrc"' _ "$DOTFILES_ROOT/scripts/bootstrap/lib.sh")"
test "$expanded_home_path" = "$HOME/.zshrc"

printf "[smoke] Makefile bootstrap paths\n"
rg -n "scripts/bootstrap/(install|backup|restore|check-deps)\.sh|scripts/tests/run\.sh|bin/(analyze_dotfiles|sync_dotfiles)" "$DOTFILES_ROOT/Makefile" >/dev/null

printf "[smoke] submodule mapping\n"
git -C "$DOTFILES_ROOT" submodule status >/dev/null

legacy_dir="$DOTFILES_ROOT/docs/_legacy/project_docs"
if [[ -d "$legacy_dir" ]]; then
  printf "[smoke] legacy project_docs is stubs-only\n"
  if find "$legacy_dir" -type f -name "*.md" -print0 | while IFS= read -r -d '' f; do
    head -n1 "$f" | rg -q '^# Legacy Stub' || echo "$f"
  done | rg -q .; then
    echo "legacy contains non-stub markdown files"
    exit 1
  fi
else
  printf "[smoke] legacy project_docs removed (ok)\n"
fi

printf "[smoke] ok\n"
