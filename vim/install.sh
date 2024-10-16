#!/bin/sh

# Script working directory
SWD="$(dirname $0)"
VIMRC="${HOME}/.vimrc"
PLUGDIR="${HOME}/.vim-plug"
SWAPDIR="${HOME}/.cache/vim"

NVIM_CONFDIR="${HOME}/.config/nvim"
#NVIMRC="${NVIM_CONFDIR}/init.vim"
NVIM_SWAPDIR="`echo ${SWAPDIR} | sed 's/vim/nvim/g'`"

cd $SWD
REPODIR=$PWD

cmd_echo() {
	echo "$@"
	$@
}

[ ! -d "${SWAPDIR}/swap" ]  && mkdir -p "${SWAPDIR}/swap"
[ ! -d "${SWAPDIR}/undo" ]  && mkdir -p "${SWAPDIR}/undo"
[ ! -d "${SWAPDIR}/view" ]  && mkdir -p "${SWAPDIR}/view"

[ ! -d "${NVIM_SWAPDIR}/swap" ]  && mkdir -p "${NVIM_SWAPDIR}/swap"
[ ! -d "${NVIM_SWAPDIR}/undo" ]  && mkdir -p "${NVIM_SWAPDIR}/undo"
[ ! -d "${NVIM_SWAPDIR}/view" ]  && mkdir -p "${NVIM_SWAPDIR}/view"

[ ! -d $PLUGDIR ]  && mkdir -p $PLUGDIR

if [ -L "${HOME}/.vim" ]; then
    cmd_echo unlink "${HOME}/.vim"
else
    mv -v "${HOME}/.vim" "${HOME}/vimconfig.old"
fi

if [ -L "${VIMRC}" ]; then
	cmd_echo unlink "${VIMRC}"
else
    mv -v "${VIMRC}" "${HOME}/vimrc.old"
fi

if [ -L "${NVIMRC}" ]; then
	cmd_echo unlink "${NVIMRC}"
else
    mv -v "${NVIMRC}" "${HOME}/init.vim.old"
fi

if [ -L "${NVIM_CONFDIR}" ]; then
	cmd_echo unlink "${NVIM_CONFDIR}"
else
    	mv -v "${NVIM_CONFDIR}" "${HOME}/init.vim.old"
fi

ln -sv "${REPODIR}/vimrc"     "${VIMRC}"
#ln -sv "${REPODIR}/init.nvim" "${NVIMRC}"
ln -sv "${REPODIR}/vimfiles"  "${HOME}/.vim"

ln -sv "${REPODIR}/nvimfiles" "${NVIM_CONFDIR}"

vim +PlugInstall +qa
