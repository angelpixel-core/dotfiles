#!/usr/bin/env zsh

asdf plugin add terraform

asdf list terraform
asdf list-all terraform

asdf install terraform 1.7.0-alpha20231025 

asdf global terraform 1.7.0-alpha20231025 

# To create the .tool-versions
# asdf local 1.7.0-alpha20231025

