
tmux_path=$(which tmux)
alias tmux="${tmux_path} -L standard"
alias tsession="${tmux_path} -L standard new-session -As"
alias datestamp='date +"%Y.%m.%d-%H:%M"'
