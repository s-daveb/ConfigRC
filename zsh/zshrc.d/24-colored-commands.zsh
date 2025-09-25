

test -n "$(env | grep -i \"__CFBundleIdentifieb=com.googlecode.iterm2\")"
is_iterm2=$?

if [ $is_iterm2 ]; then
	alias ls="lsd --icon-theme=fancy"
else
	alias ls="lsd --icon-theme=unicode"
fi

alias lsl="lsd -lt"
alias lstree="ls --tree --depth=2"
