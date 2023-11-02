#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
# Utils
# ------------------------------------------------------------------------------
alias sudo="sudo " # Enable aliases to be sudo’ed


# ------------------------------------------------------------------------------
# Navigation
# ------------------------------------------------------------------------------
alias ".."="cd .."
alias ...="cd ../.."
alias ~="cd ~"
alias md="mkdir -p"
alias rd="rmdir"

alias dotfiles="cd $DOTFILES_PATH"
alias sites="cd $HOME/Sites"

alias ll="exa -l"
alias la="exa -la"


# ------------------------------------------------------------------------------
# Git
# ------------------------------------------------------------------------------
alias ga="git add"
alias gc="git commit -m"
alias gca="git add --all && git commit --amend --no-edit"
alias gco="git checkout"
alias gd="git diff"
alias gs="git st -sb"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpsf="git push --force"
alias gpl="git pull --rebase --autostash"
alias gr="git reset"
alias grh="gr HEAD"
alias gb="git branch"
alias gl="git log --oneline"


# ------------------------------------------------------------------------------
# Editors
# ------------------------------------------------------------------------------
alias o="open $PWD"
alias v="nvim"
alias vim="nvim"


# ------------------------------------------------------------------------------
# Processes
# ------------------------------------------------------------------------------
alias k="kill -9"

