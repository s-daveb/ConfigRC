
if [ -z "$(echo "${PATH}" | grep "/usr/local/opt/go/libexec/bin")" ]; then
	export PATH="/usr/local/opt/go/libexec/bin:$PATH"
fi

if [ -d "${HOME}/.cargo/bin" ]; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi


