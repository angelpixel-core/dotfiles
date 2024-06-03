#!/usr/bin/env zsh

# https://thinkingelixir.com/install-elixir-using-asdf/

# Install Erlang Virtual Machine
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf install erlang 27.0 
asdf global erlang 27.0 

# Install Elixir
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install elixir 1.17.0-rc.1-otp-27
asdf global elixir 1.17.0-rc.1-otp-27

