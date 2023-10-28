# Setup via ASDF

## Dependencies
brew install gawk
brew install gpg

## Install the Plugin
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

lastest="21.1.0"
## Setup Latest
asdf install nodejs ${latest}

## Set Global version
asdf global nodejs ${latest}

