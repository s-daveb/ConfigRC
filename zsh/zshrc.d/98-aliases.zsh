alias ytdl="yt-dlp -S codec:h264:m4a"

function colorls_wrapper()
{
	color_param="--dark"

	defaults read -g AppleInterfaceStyle 1> /dev/null 2> /dev/null

	if [[ $? -ne 0 ]]; then
		color_param="--light"
	fi

	colorls --gs ${color_param} ${@}
}

function alias_colorls()
{
	if [ -x $(which colorls) ]; then
		alias ls="colorls_wrapper"
	else
		alias ls="ls --color=auto"
	fi
}

alias_colorls
