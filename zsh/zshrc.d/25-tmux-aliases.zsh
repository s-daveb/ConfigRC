
unalias tmux 2> /dev/null
tmux_path=$(which tmux)

if [ -n "$tmux_path" ]; then
	function get_tmux_socket()
	{
		echo "${TMUX}" | sed 's/,.*//'
	}

	function tmux_with_current_socket()
	{
		tmux_socket=`get_tmux_socket`
		to_run=""
		if [ -n "${tmux_socket}" ]; then
			to_run="${tmux_path} -S ${tmux_socket}  ${@}"
		else
			to_run="${tmux_path} ${@}"
		fi

		echo  "running '$to_run'"
		eval $to_run
	}

	alias tmuxcmd="tmux_with_current_socket"
fi
