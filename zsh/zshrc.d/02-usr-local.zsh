
if [ -n "${HOMEBREW_PREFIX}" ]; then
	export PATH="${HOMEBREW_PREFIX}/sbin:${HOMEBREW_PREFIX}/bin:${PATH}"
fi

if [ -x "$(command -v brew)" ]; then
	eval "$(brew shellenv)"
fi

# vim: ft=zsh ts=4 sts=4 sw=4 noet :
