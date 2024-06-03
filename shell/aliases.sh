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
alias md="mkdir -p "
alias rd="rm -rf "

alias dotfiles="cd $DOTFILES_PATH"
alias sites="cd $HOME/Sites"

# ------------------------------------------------------------------------------
# ---- Eza (better ls) ---------------------------------------------------------
# ------------------------------------------------------------------------------
alias ls="eza --color=always --long --all --git --no-filesize --icons=always --no-time --no-user --no-permissions -1"
alias ls1="ls --tree --level=1"
alias ls2="ls --tree --level=2"

# ------------------------------------------------------------------------------
# ---- Bat (beter cat) ---------------------------------------------------------
# ------------------------------------------------------------------------------

#  Check themes in your directory
#  don't forget to clone bat_theme config, check it out in README.md file
#  bat --list-themes | fzf --preview="bat --theme={} --color=always <PATH_TO_YOUR_SAMPLE_VIEW>"

export BAT_THEME="tokyonight_night"


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

