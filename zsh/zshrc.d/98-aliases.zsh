alias bstart="brew services start"
alias bstop="brew services stop"

alias brestart="brew services restart"

function colorls_cmd_generator()
{
	color_param="--light"

	# colorls should only be in light mode if the session is not
	# coming through an iTerm tmux session
	if [[ "${TERM_PROGRAM}" == "tmux"  ]] || [[ $(date +"%H") -gt 17 ]]; then
		color_param="--dark"
	fi

	echo "colorls --gs ${color_param}"
}

function alias_colorls()
{
	colorls 2> /dev/null 1> /dev/null
	colorls_result=$?

	colorls_cmd="$(colorls_cmd_generator)"
	if [ $colorls_result -eq 0 ]; then
		alias ls="${colorls_cmd}"
	else
		alias ls="ls --color=auto"
	fi
}

alias_colorls

alias usystemctl="systemctl --user"
alias docker="sudo docker"
alias podman="sudo podman"
alias docker-compose="sudo docker-compose"
