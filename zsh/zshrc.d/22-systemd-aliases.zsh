
alias usystemctl="systemctl --user"
alias ujournalctl="journalctl --user"

alias slow_tmux="/usr/bin/tmux -L low_cpu_priority"
alias tmuxupdate="slow_tmux new-session -As update systemd-run --user -p CPUWeight=50 -p CPUQuota=50% --pty $SHELL"
