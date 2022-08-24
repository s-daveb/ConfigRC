if [ -z "$(echo "${PATH}" | grep "/usr/local/opt/texinfo/bin")" ]; then
	export PATH="/usr/local/opt/texinfo/bin:$PATH"
fi
