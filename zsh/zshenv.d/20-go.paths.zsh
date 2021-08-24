
if [ -z "$(echo "${PATH}" | grep "/usr/local/opt/go/libexec/bin")" ]; then
	export PATH="/usr/local/opt/go/libexec/bin:$PATH"
fi


