#!/usr/bin/env zsh

# Setup Rust via ASDF

## Dependencies
brew install ripgrep
brew install fd

## Install the Plugin
asdf plugin add rust https://github.com/asdf-community/asdf-rust.git

## Setup Latest
asdf install rust latest

## Set Global version
asdf global rust latest

