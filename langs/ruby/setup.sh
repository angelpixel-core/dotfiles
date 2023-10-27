#!/usr/bin/env zsh

asdf plugin add ruby

asdf list ruby
asdf list-all ruby

asdf install ruby 3.3.0-preview2 

asdf global ruby 3.3.0-preview2

# To create the .tool-versions
 asdf install ruby 3.2.2 
# asdf local ruby 2.2.2 

