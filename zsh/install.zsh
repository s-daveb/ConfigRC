#!/usr/bin/env zsh

# Script working directory
SWD="$(dirname $0)"

cd $SWD
REPODIR=$PWD

cd $HOME

[[ ! -d $HOME/.zsh ]] && mkdir -pv ${HOME}/.zsh

if [[ -d ${HOME}/.zsh/completions ]] && [[ ! -L ${HOME}/.zsh/completions ]]; then
	echo "detected existing completions, moving to ~/.zsh/completions.old"
	mv ${HOME}/.zsh/completions{,.old}
fi

unlink "${HOME}/.zshrc"
unlink "${HOME}/.zshenv"
unlink "${HOME}/.zshen.d" 2> /dev/null
unlink "${HOME}/.zshrc.d"
unlink "${HOME}/.zsh/completions" 2> /dev/null

ln -sv "${REPODIR}/zshrc" "${HOME}/.zshrc"
ln -sv "${REPODIR}/zshenv" "${HOME}/.zshenv"
ln -sv "${REPODIR}/zshrc.d" "${HOME}/.zshrc.d"
ln -sv "${REPODIR}/completions" "${HOME}/.zsh"

