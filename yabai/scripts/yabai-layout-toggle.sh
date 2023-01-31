#!/bin/sh

source ~/.yabai-sh.env

current_layout="$(yabai -m config layout)"

layout_name=""

case $current_layout in
	"bsp")
		current_layout="float"
		;;
	"float")
		current_layout="bsp"
		;;
	"stack")
		current_layout="bsp"
		;;
esac

yabai -m config layout $current_layout

sys-notify "${current_layout}" "Yabai" "layout changed to:"
