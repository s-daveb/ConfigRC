if [ -x "$(which exa 2>/dev/null)" ]; then
	alias ls="lsd"
else
	alias ls="ls --color=auto"
fi
