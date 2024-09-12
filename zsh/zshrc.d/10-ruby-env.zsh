
#source ~/.zshrc.d/common.zsh

if [ ! -d "${HOME}/.rbenv" ]; then
	mkdir -p "${HOME}/.rbenv"
fi

export PATH="$(prepend_path "${HOME}/.rbenv/bin" "${PATH}")"

eval "$(rbenv init -)"

# vim: set ft=zsh ts=2 sw=2 noet sts=2 :
