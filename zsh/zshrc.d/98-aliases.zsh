

function sudo()
{
	doas_args=""
	if [ "$1" = "-i" ]; then
		doas_args="-s"
		shift
	fi

	doas ${doas_args} ${@}
}

alias bastille="doas bastille"

