#!/bin/sh

current_layout="$(yabai -m config layout)"

function _sys_notify() {
	local notification_command="display notification \"$1\" with title \"$2\" subtitle \"$3\""
	osascript -e "$notification_command"
}

alias sys-notify="_sys_notify $1 $2"

layout_name=""

case $current_layout in
	"bsp")
		yabai -m config layout float
		current_layout="float"
		;;
	"float")
		yabai -m config layout stack
		current_layout="stack"
		;;
	"stack")
		yabai -m config layout bsp
		current_layout="bsp"
		;;
esac

sys-notify "${current_layout}" "Yabai" "layout changed to:"
