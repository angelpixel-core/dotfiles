export DOTFILES_ROOT="$HOME/.dotfiles"

source "$DOTFILES_ROOT/shell/init.sh"

if [ -n "$(ls -A "$DOTFILES_ROOT/shell/bash/completions/")" ]; then
  for bash_file in "$DOTFILES_ROOT"/shell/bash/completions/_*; do
    source "$bash_file"
  done
fi


# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/angel.szymczak/.lmstudio/bin"
# End of LM Studio CLI section

