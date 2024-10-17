#!/bin/sh

# Script working directory
REPODIR="$(dirname $0)"
NVIM_CACHEDIR="${HOME}/.cache/nvim"
NVIM_CONFDIR="${HOME}/.config/nvim"

cd $REPODIR

cmd_echo() {
	echo "$@"
	$@
}

if [ ! -d "${NVIM_CACHEDIR}" ] && [ ! -L "${NVIM_CACHEDIR}" ]; then
	mkdir -p "${NVIM_CACHEDIR}"
fi

[ ! -d "${NVIM_CACHEDIR}/swap" ]  && mkdir -p "${NVIM_CACHEDIR}/swap"
[ ! -d "${NVIM_CACHEDIR}/undo" ]  && mkdir -p "${NVIM_CACHEDIR}/undo"
[ ! -d "${NVIM_CACHEDIR}/view" ]  && mkdir -p "${NVIM_CACHEDIR}/view"


if [ -L "${NVIM_CONFDIR}" ]; then
	cmd_echo unlink "${NVIM_CONFDIR}"
else
    	mv -v "${NVIM_CONFDIR}" "${HOME}/init.vim.old"
fi

ln -sv "${REPODIR}/nvimfiles" "${NVIM_CONFDIR}"

echo "nvim confiugration files installed"
echo "Plugins will be lazy-loaded by lazy.nvim when you open nvim for the first time"
