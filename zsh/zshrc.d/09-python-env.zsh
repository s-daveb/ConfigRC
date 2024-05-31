local python_venv_path="${HOME}/.local/python/"
alias venv-activate="source ${python_venv_path}/bin/activate"

export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
