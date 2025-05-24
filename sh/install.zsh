#!/usr/bin/env zsh

# Script working directory
SWD="$(dirname $0)"

cd $SWD
REPODIR=$PWD

cd $HOME

unlink "${HOME}/.profile"

ln -sv "${REPODIR}/profile" "${HOME}/.profile"
