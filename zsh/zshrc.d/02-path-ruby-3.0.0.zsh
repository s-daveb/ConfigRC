
GEM_BIN=`which gem`


if [ -x "${GEM_BIN}" ]; then
	RUBYPATHS=$(${GEM_BIN} environment path | sed 's/:/\n/g')

	for rubypath in ${=RUBYPATHS}; do
		export PATH="${PATH}:${rubypath}/bin"
	done
fi

