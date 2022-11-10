#!/usr/bin/env zsh

# Script working directory
SWD="$(dirname $0)"

cd $SWD
REPODIR=$PWD

cd $HOME

unlink "${HOME}/.zshrc"
unlink "${HOME}/.zshenv"
unlink -R "${HOME}/.zshenv.d" 2> /dev/null
unlink -R "${HOME}/.zshrc.d" 2> /dev/null

ln -sv "${REPODIR}/zshrc" "${HOME}/.zshrc"
ln -sv "${REPODIR}/zshenv" "${HOME}/.zshenv"
ln -sv "${REPODIR}/zshrc.d" "${HOME}/.zshrc.d"

