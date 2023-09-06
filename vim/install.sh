#!/bin/sh

# Script working directory
SWD="$(dirname $0)"
PLUGDIR="${HOME}/.vim-plug"
SWAPDIR="${HOME}/.cache/vim"

cd $SWD
REPODIR=$PWD

[ ! -d "${SWAPDIR}/swap" ]  && mkdir -p "${SWAPDIR}/swap"
[ ! -d "${SWAPDIR}/undo" ]  && mkdir -p "${SWAPDIR}/undo"
[ ! -d "${SWAPDIR}/view" ]  && mkdir -p "${SWAPDIR}/view"

[ ! -d $PLUGDIR ]  && mkdir -p $PLUGDIR

if [ -L "${HOME}/.vim" ]; then
    unlink  "${HOME}/.vim"
else
    mv -v "${HOME}/.vim" "${HOME}/vimconfig.old"
fi

if [ -L "${HOME}/.vimrc" ]; then
	unlink "${HOME}/.vimrc"
else
    mv -v "${HOME}/.vimrc" "${HOME}/vimrc.old"
fi

ln -sv "${REPODIR}/vimrc"    "$HOME/.vimrc"
ln -sv "${REPODIR}/vimfiles" "$HOME/.vim"
