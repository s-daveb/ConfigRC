
if [ -z "$(echo "${PATH}" | grep "/opt/homebrew/opt/go/libexec/bin")" ]; then
	export PATH="/opt/homebrew/opt/go/libexec/bin:$PATH"
fi


