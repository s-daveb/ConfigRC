
function doas() {
	sudo_args=""
	if [ "$1" = "-S" ] || [ "$1" = "-s" ]; then
		sudo_args="-i"
		shift
	fi
	sudo ${sudo_args} ${@}
}

alias usystemctl="systemctl --user" 
