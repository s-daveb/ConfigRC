
GEM_BIN=`which gem`

if [ -x "${GEM_BIN}" ]; then
	export PATH="${PATH}:$(${GEM_BIN} environment path)"
fi
