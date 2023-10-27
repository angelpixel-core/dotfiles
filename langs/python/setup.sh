#!/usr/bin/env zsh

asdf plugin add python https://github.com/asdf-community/asdf-python

asdf list 

asdf install python 3.13-dev 

asdf global python 3.13-dev 

###############################################################################
# A common request for Python is being able to use the python2 and python3
# commands without needing to switch version. This can be achieved by
# setting multiple versions of Python, for example with
#
# asdf global python 3.6.2 2.7.13
#
# Executables in the first version will take priority over the executables in
# the next one. Note that you can use an arbitrary number over versions, if
# needed. With the above example, python will therefore use the python
# executable found in version 3.6.2.
# However, as the python2 does not exist in Python 3.6.2, python2 will use the
# python2 executable found in version 2.7.13.
#
# python -V
# Python 3.6.2
#
# python3 -V
# Python 3.6.2
#
# python2 -V
# Python 2.7.13
#
## Pip installed modules and binaries
# If you use pip to install a module like ipython that has binaries. You will
# need to run asdf reshim python for the binary to be in your path.
#
# You can specify a non-default location of this file by setting a
# ASDF_PYTHON_DEFAULT_PACKAGES_FILE variable.
###############################################################################

