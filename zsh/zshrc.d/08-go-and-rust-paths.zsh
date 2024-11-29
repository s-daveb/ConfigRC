
if [ -z "$(echo "${PATH}" | grep "${HOMEBREW_PREFIX}/opt/go/libexec/bin")" ]; then
	export PATH="${HOMEBREW_PREFIX}/opt/go/libexec/bin:$PATH"
fi

if [ -d "${HOME}/.cargo/bin" ]; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi


