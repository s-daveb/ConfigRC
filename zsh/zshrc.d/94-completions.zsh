
comp_dir=${HOME}/.zsh/completions

if [[ -d ${comp_dir} ]]; then

	fpath=(${comp_dir} $fpath)
fi

autoload -Uz compinit
compinit

