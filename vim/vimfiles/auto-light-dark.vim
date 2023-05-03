
" This is a comment
function _common_colorsettings()
	let g:everforest_better_performance = 1
	let g:everforest_background = 'medium'
	let g:everforest_transparent_background=1
	let g:everforest_ui_contrast = 'high'
endfunction

function DarkMode()
    set background=dark
	call _common_colorsettings()

	if ( $TMUX != "" )
		colorscheme  everforest
		AirlineTheme  everforest
	else
		colorscheme dracula
		AirlineTheme dracula
	endif
	call TransparentTerminalFix()
	call UiConfig()
endfunction

function LightMode()
    set background=light
	call _common_colorsettings()
	echo "light mode"
	if ( $TMUX != "" )
    	set background=dark
		colorscheme  everforest
		AirlineTheme  everforest
	else
		set background=dark
		colorscheme dracula
		AirlineTheme dracula
	endif
	call TransparentTerminalFix()
	call UiConfig()
endfunction

