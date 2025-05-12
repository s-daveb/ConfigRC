
if [ -x "$(which gman)" ]; then
	alias man="$(which gman)"
fi

if [ -n "$MANPATH" ]; then
	export MANPATH=${MANPATH}:${HOME}/.cache/cppman/cppreference.com
else
	export MANPATH=${HOME}/.cache/cppman/cppreference.com
fi
