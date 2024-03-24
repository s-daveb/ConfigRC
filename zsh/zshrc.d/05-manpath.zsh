
if [ -x "$(which gman)" ]; then
	alias man="$(which gman)"
fi
export MANPATH=:${HOME}/.cache/cppman/cppreference.com
