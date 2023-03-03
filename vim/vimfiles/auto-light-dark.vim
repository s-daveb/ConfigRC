

function DarkMode()
    set background=dark
	colorscheme dracula
	AirlineTheme dracula
	call GuiConfig()
endfunction

function LightMode()
	if ( $TMUX != "" )
    	set background=light
		colorscheme  everforest
		AirlineTheme  everforest
	else
    	set background=dark
		colorscheme dracula
		AirlineTheme dracula
	endif
	call GuiConfig()
endfunction

