#!/usr/bin/env zsh

asdf plugin add julia

asdf list julia
asdf list-all julia

latest="1.9.3"

asdf install julia ${latest}

asdf global julia ${latest}

