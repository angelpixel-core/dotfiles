#!/usr/bin/env zsh

asdf plugin add lua

asdf list lua
asdf list-all lua

latest="5.4.6"
asdf install lua ${latest}

asdf global lua ${latest}

