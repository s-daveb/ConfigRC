#!/bin/sh

source ~/.yabai-sh.env

launchctl kickstart -k gui/501/homebrew.mxcl.yabai

if [ $? -eq 0 ]; then
	sys-notify "Restarting service..." "Yabai" "launchctl status"
else
	sys-notify "Check that yabairc is correct, and yabai is enabled" "Yabai" "error"
fi
