alias bstart="brew services start"
alias bstop="brew services stop"

alias brestart="brew services restart"

function colorls_cmd_generator()
{
	color_param="--dark"

	# colorls should only be in light mode if the session is 
	# coming through an iTerm tmux session
	
	if [[ -n "$TMUX" ]] &&[[ $(date +"%H") -lt 18 ]] && [[ $(date +"%H") -gt 7 ]]; then
		color_param="--light"
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
		if [ -x "$(which exa 2>/dev/null)" ]; then
			alias ls="exa"
		else
			alias ls="ls --color=auto"
		fi
	fi
}

alias_colorls

alias usystemctl="systemctl --user"

alias pacman="sudo pacman"

alias tsession="tmux new-session -As"

alias tmuxupdate="systemd-run --user -p CPUWeight=50 -p CPUQuota=50% --pty tmux new-session -As update"
