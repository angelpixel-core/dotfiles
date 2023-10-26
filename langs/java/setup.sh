#!/usr/bin/env zsh

asdf plugin add java

asdf list java
asdf list-all java
asdf list-all java open

asdf install java openjdk-21 

asdf global java openjdk-21.0.1

# To create the .tool-versions
# asdf install java openjdk-21 
# asdf local openjdk-19.0.1

