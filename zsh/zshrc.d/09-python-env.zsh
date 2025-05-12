VIRTUAL_ENV="$HOME/.venv"
reinstall=0

if [ ! -d "$VIRTUAL_ENV" ]; then
	mkdir -p "$VIRTUAL_ENV"
	python3 -m venv "$VIRTUAL_ENV"
	reinstall=1
fi

export VIRTUAL_ENV
export PATH="$VIRTUAL_ENV/bin:$PATH"

if [ $reinstall -eq 1 ]; then
	pip install --upgrade pip setuptools wheel
fi

if [ -x "$(command -v micromamba)" ]; then
	function micromamba_init()
	{
		shell="${1:-dash}"

		case "$shell" in
			dash)
				# Code for dash shell
				env -i PATH="$PATH" HOME="$HOME" TERM="$TERM" /bin/dash -l
				;;
			sh)
				# Code for bash sh shell
				env -i PATH="$PATH" HOME="$HOME" TERM="$TERM" /bin/sh -l
				;;
			zsh)
				# Code for zsh shell
				env -i PATH="$PATH" HOME="$HOME" TERM="$TERM" /bin/zsh --no-rcs -l
				;;
			*)
				case "$SHELL" in
					dash)
						# Code for bash shell
						env -i PATH="$PATH" HOME="$HOME" TERM="$TERM" /bin/dash -l
						;;
					zsh)
						# Code for zsh shell
						env -i PATH="$PATH" HOME="$HOME" TERM="$TERM" /bin/zsh --no-rc -l
						;;
					*)
						echo "using unsupported shell" 1>&2
						return
						;;
				esac
		esac
	}
fi

# vim: set ts=4 sts=4 noet sw=4 :
