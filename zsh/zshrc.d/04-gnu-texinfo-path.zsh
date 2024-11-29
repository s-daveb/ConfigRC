
if [ -z "$(echo "${PATH}" | grep "${HOMEBREW_PREFIX}/opt/texinfo/bin")" ]; then
	export PATH="${HOMEBREW_PREFIX}/opt/texinfo/bin:$PATH"
fi
