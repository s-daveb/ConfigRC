#!/usr/bin/env zsh

# Script working directory
SWD="$(dirname $0)"

scripts_dest="${HOME}/.bin"

REPO=$PWD
cd $SWD

scripts_dir="scripts"

unlink "${HOME}/.skhdrc"
unlink "${HOME}/.yabairc"
unlink "${HOME}/.yabai-sh.env"

if [ ! -d "${scripts_dest}" ]; then
	mkdir -pv "${scripts_dest}"
	echo "Created \"${scripts_dest}\""
   	echo "Please add \"${scripts_dest}\" to your path"
fi

for F in ${scripts_dir}/*.sh; do
	script_name="$(basename $F)"
	rm -v "${scripts_dest}/${script_name}" 2> /dev/null
	ln -sv "${REPO}/${F}" "${scripts_dest}/${script_name}"
done

echo

ln -sv "${REPO}/yabai-sh.env" "${HOME}/.yabai-sh.env"
ln -sv "${REPO}/yabairc" "${HOME}/.yabairc"
ln -sv "${REPO}/skhdrc" "${HOME}/.skhdrc"

chmod +x "${HOME}/.bin/${layout_script}"
