alias tmuxupdate="systemd-run --user -p CPUWeight=50 -p CPUQuota=50% --pty tmux new-session -As update"
