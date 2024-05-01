
" This is a comment
function _everforest_settings()
	if !has("gui_running")
		let g:everforest_transparent_background=2
	endif
	let g:everforest_better_performance = 0
	let g:everforest_background = 'medium'
	let g:everforest_transparent_background=1
	let g:everforest_ui_contrast = 'high'
endfunction

function DarkMode()
    set background=dark

	if ( $ITERM == "1" )
		call _everforest_settings()
		colorscheme  dracula
		AirlineTheme dracula
	else
		colorscheme dracula
		AirlineTheme dracula
	endif
	call TransparentTerminalFix()
endfunction

function LightMode()
    set background=light

	if ( $ITERM == "1" )
		call _everforest_settings()
    	set background=dark
		colorscheme  everforest
		AirlineTheme  everforest
	else
		set background=dark
		colorscheme dracula
		AirlineTheme dracula
	endif
	call TransparentTerminalFix()
endfunction

