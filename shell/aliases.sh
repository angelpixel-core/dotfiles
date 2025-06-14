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
# Git
# ------------------------------------------------------------------------------
alias ga="git add"
alias gc="git cz"
alias gca="git add --all && git commit --amend --no-edit"
alias gco="git checkout"
alias gd="git diff"
alias gs="git st -sb"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpsf="git push --force"
alias gpl="git pull --rebase --autostash"
alias gr="git reset"
alias gra="git rebase --abort"
git_rebase_interactive() {
  git rebase -i "$1~1"
}
alias gri="git_rebase_interactive"
alias grc="git rebase --continue"
alias grh="gr HEAD"
alias gb="git branch"
alias gl="git log --oneline"


# ------------------------------------------------------------------------------
# Editors
# ------------------------------------------------------------------------------
alias o="open $PWD"

# Powered NeoVIM helpers ------------------------------------------------------
n() {
  if [[ "$1" =~ ^([^:]+):([0-9]+):([0-9]+)$ ]]; then
    FILE="${match[1]}"
    LINE="${match[2]}"
    COL="${match[3]}"
    nvim +"call cursor($LINE, $COL)" "$FILE"
  elif [[ "$1" =~ ^([^:]+):([0-9]+)$ ]]; then
    FILE="${match[1]}"
    LINE="${match[2]}"
    nvim +$LINE "$FILE"
  else
    nvim "$@"
  fi
}
alias v="n"
alias vim="n"


# ------------------------------------------------------------------------------
# Processes Monitor
# ------------------------------------------------------------------------------
# alias top="btm --color gruvbox "
alias top="btop"

# ------------------------------------------------------------------------------
# Time Monitor
# ------------------------------------------------------------------------------
function now() {
  date +"%H:%M:%S"
}

# ------------------------------------------------------------------------------
# Time Monitor
# ------------------------------------------------------------------------------
function now() {
  date +"%H:%M:%S"
}

# ------------------------------------------------------------------------------
# Session Tab Name
# ------------------------------------------------------------------------------
# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# iTerm2 tab titles
function title {
    if [ "$1" ]
    then
        export PROMPT_COMMAND='__bp_precmd_invoke_cmd'
        echo -ne "\033]0;${*}\007"
    else
        export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/\~}\007";__bp_precmd_invoke_cmd'
    fi
}
title

