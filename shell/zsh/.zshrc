export DOTFILES_ROOT="$HOME/.dotfiles"

#!/usr/bin/env zsh
# Uncomment for debuf with `zprof`
# zmodload zsh/zprof

# ZSH Options
# TODO: check about these zsh configs
# setopt HIST_IGNORE_ALL_DUPS
# setopt HIST_FCNTL_LOCK
# setopt +o nomatch
# setopt autopushd

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Start Zim
source "$ZIM_HOME/init.zsh"

# TODO: check about filter "cd" commands in shell history by environment zim module

# Async mode for autocompletion
ZSH_AUTOSUGGEST_USE_ASYNC=true
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

# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# Created by `pipx` on 2025-06-22 00:23:57
export PATH="$PATH:/Users/angel.szymczak/.local/bin"
