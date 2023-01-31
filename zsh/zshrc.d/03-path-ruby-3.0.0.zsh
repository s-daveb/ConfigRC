
GEM_BIN=`which gem`

if [ -x "${GEM_BIN}" ]; then
	echo PATH="${PATH}:$(gem environment path)"
fi
