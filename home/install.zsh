#!/usr/bin/env zsh

# Script working directory
SWD="$(dirname $0)"

cd $SWD
REPODIR=$PWD

cd $HOME


unlink "${HOME}/.conda"
unlink "${HOME}/.condarc"

ln -sv "${REPODIR}/conda" "${HOME}/.conda"
ln -sv "${REPODIR}/condarc" "${HOME}/.condarc"

