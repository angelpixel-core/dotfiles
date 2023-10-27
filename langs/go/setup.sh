#!/usr/bin/env zsh

# Setup Go via ASDF

## Dependencies
brew install coreutils

## Install the Plugin
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git

## Setup Latest
asdf install golang latest

## Set Global version
asdf global golang latest

## GOROOT
### To set GOROOT in your shell's initialization add the following:
### zsh shell
. ~/.asdf/plugins/golang/set-env.zsh

## When using go get or go install
# After using go get or go install to install a package you need to run asdf
# reshim golang to get any new shims.
#
## Default go get packages
# asdf-golang can automatically install a default set of packages with
# `go get -u $PACKAGE` right after installing a new Go version.
# To enable this feature, provide a `$HOME/.default-golang-pkgs` file that
# lists one package per line, for example:
#
#  // allows comments
#  github.com/Dreamacro/clash
#  github.com/jesseduffield/lazygit
#
# You can specify a non-default location of this file by setting a
# ASDF_GOLANG_DEFAULT_PACKAGES_FILE variable.

