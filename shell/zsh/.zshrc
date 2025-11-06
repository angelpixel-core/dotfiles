export DOTFILES_ROOT="$HOME/.dotfiles"

#!/usr/bin/env zsh
# Uncomment for debuf with `zprof`
# zmodload zsh/zprof

# ZSH Options
# TODO: check about these zsh configs
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_VERIFY

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Start Zim
source "$ZIM_HOME/init.zsh"

# TODO: check about filter "cd" commands in shell history by environment zim module

# Async mode for autocompletion
# ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300

source "$DOTFILES_ROOT/shell/init.sh"

# TODO: check if should be removed
# fpath=(
#   "$DOTFILES_ROOT/shell/zsh/themes"
#   "$DOTFILES_ROOT/shell/zsh/completions"
#   $fpath
# )

# TODO: check, what does this mean?
# autoload -Uz promptinit && promptinit

# TODO: check if should be removed
# source "$DOTFILES_ROOT/shell/zsh/key-bindings.zsh"

# Set editor default keymap to emacs (`e`) or vi (`-v`)
bindkey -e



# bun completions
[ -s "/Users/angel.szymczak/.bun/_bun" ] && source "/Users/angel.szymczak/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Created by `pipx` on 2025-06-22 00:23:57
export PATH="$PATH:/Users/angel.szymczak/.local/bin"

# pnpm
export PNPM_HOME="/Users/angel.szymczak/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# Alias for running starkup installer
alias starkup="curl --proto '=https' --tlsv1.2 -sSf https://sh.starkup.sh | sh -s --"

# BEGIN SCARB COMPLETIONS
_scarb() {
  if ! scarb completions zsh >/dev/null 2>&1; then
    return 0
  fi
  eval "$(scarb completions zsh)"
  _scarb "$@"
}

autoload -Uz compinit && compinit
compdef _scarb scarb
# END SCARB COMPLETIONS

# BEGIN FOUNDRY COMPLETIONS
_snforge() {
  if ! snforge completions zsh >/dev/null 2>&1; then
    return 0
  fi
  eval "$(snforge completions zsh)"
  _snforge "$@"
}

_sncast() {
  if ! sncast completions zsh >/dev/null 2>&1; then
    return 0
  fi
  eval "$(sncast completions zsh)"
  _sncast "$@"
}

compdef _snforge snforge
compdef _sncast sncast
# END FOUNDRY COMPLETIONS
. "/Users/angel.szymczak/.starkli/env"
export AWS_PROFILE=angel-solutions
