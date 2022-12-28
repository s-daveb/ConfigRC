#!/bin/sh

source ~/.yabai-sh.env

current_layout="$(yabai -m config layout)"

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
