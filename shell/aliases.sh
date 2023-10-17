# Utils
alias up='dot package update_all'
alias sudo='sudo ' # Enable aliases to be sudo’ed

# Directory
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'
alias md='mkdir -p'
alias rd='rmdir'

alias dotfiles='cd $DOTFILES_PATH'
alias sites='cd $HOME/Sites'

alias ll='exa -l'
alias la='exa -la'

# Git
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -m'
# alias gc='$DOTLY_PATH/bin/dot git commit'
alias gca='git add --all && git commit --amend --no-edit'
alias gco='git checkout'
alias gd='git diff'
# alias gd='$DOTLY_PATH/bin/dot git pretty-diff'
alias gs='git status -sb'
alias gf='git fetch --all -p'
alias gps='git push'
alias gpsf='git push --force'
alias gpl='git pull --rebase --autostash'
alias gb='git branch'
alias gl='git log'
# alias gl='$DOTLY_PATH/bin/dot git pretty-log'

# Editors
alias i.='(idea $PWD &>/dev/null &)'
alias c.='(code $PWD &>/dev/null &)'
alias o.='open $PWD'
alias v.='vim $PWD'

# Processes
alias k='kill -9'

