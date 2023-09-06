if [ -z "$(echo "${PATH}" | grep "/opt/homebrew/opt/texinfo/bin")" ]; then
	export PATH="/opt/homebrew/opt/texinfo/bin:$PATH"
fi
