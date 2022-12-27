#!/usr/bin/env zsh

# Script working directory
SWD="$(dirname $0)"
layout_script="yabai-layout-toggle.sh"

cd $SWD
REPODIR=$PWD

cd $HOME

unlink "${HOME}/.skhdrc"
unlink "${HOME}/.yabairc"
unlink "${HOME}/.bin/${layout_script}" 2> /dev/null

if [ -d "${HOME}/.bin" ]; then
	mkdir -pv "${HOME}/.bin"
	echo "Created \"${HOME}/.bin\""
   	echo "Please add \"${HOME}/.bin\" to your path"
fi

ln -sv "${REPODIR}/yabairc" "${HOME}/.yabairc"
ln -sv "${REPODIR}/skhdrc" "${HOME}/.skhdrc"
ln -sv "${REPODIR}/${layout_script}" "${HOME}/.bin/"

chmod +x "${HOME}/.bin/${layout_script}"
