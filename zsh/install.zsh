#!/usr/bin/env zsh

# Script working directory
SWD="$(dirname $0)"

ZPLUG_LINK_DEST="${HOME}/.local/share"

cd $SWD
REPODIR=$PWD

cd $HOME

# Clear out old config
unlink "${HOME}/.zshrc"
unlink "${HOME}/.zshenv"

unlink "${HOME}/.zshenv.d" 2> /dev/null
unlink "${HOME}/.zshrc.d" 2> /dev/null
unlink "${ZPLUG_LINK_DEST}/zplug" 2> /dev/null

# Link zplug

[ ! -d "${ZPLUG_LINK_DEST}" ] && mkdir -pv "${ZPLUG_LINK_DEST}"
ln -sv "${REPODIR}/dependencies/zplug" "${ZPLUG_LINK_DEST}"

ln -sv "${REPODIR}/zshenv" "${HOME}/.zshenv"
ln -sv "${REPODIR}/zshrc" "${HOME}/.zshrc"
ln -sv "${REPODIR}/zshrc.d" "${HOME}/.zshrc.d"
