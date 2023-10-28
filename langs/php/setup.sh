#!/usr/bin/env zsh
brew install gmp libsodium imagemagick autoconf automake libtool re2c bison
brew install freetype gd gettext icu4c krb5 libedit libiconv libjpeg libpng libxml2 libzip openssl@1.1 pkg-config re2c zlib

asdf plugin-add php https://github.com/asdf-community/asdf-php.git

asdf list php
asdf list-all php

asdf install php 8.3.0beta3

asdf global php 8.3.0beta3

# Note that the supported extension are not exhaustive, so you may need edit
# the bin/install script to support additional extension. Feel free to submit
# a PR for any missing extensions.

# Global Composer Dependencies
#
# Composer is installed globally by default. To use it, you'll need to reshim:
# 
# composer global require friendsofphp/php-cs-fixer
# asdf reshim
# php-cs-fixer --version

