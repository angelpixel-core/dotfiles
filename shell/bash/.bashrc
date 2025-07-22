export DOTFILES_ROOT="$HOME/.dotfiles"

source "$DOTFILES_ROOT/shell/init.sh"

EXPORTED_PATH=$(
  IFS=":"
  echo "${path[*]}"
)
export PATH="$PATH:$EXPORTED_PATH"

if [ -n "$(ls -A "$DOTFILES_ROOT/shell/bash/completions/")" ]; then
  for bash_file in "$DOTFILES_ROOT"/shell/bash/completions/_*; do
    source "$bash_file"
  done
fi


# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'
