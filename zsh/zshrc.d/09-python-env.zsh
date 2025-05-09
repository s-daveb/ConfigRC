## >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/opt/homebrew/opt/micromamba/bin/mamba';
export MAMBA_ROOT_PREFIX='/Users/sdavid/.mamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# Skip .venv setup if conda is already in use
if [ -z "$MAMBA_ROOT_PREFIX" ]; then
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
else
	# Conda init (only if installed)
	if [ -x "/opt/homebrew/Caskroom/miniconda/base/bin/conda" ]; then
		eval "$(/opt/homebrew/Caskroom/miniconda/base/bin/conda shell.zsh hook)"
	fi
fi


# vim: set ts=4 sts=4 noet sw=4 :
