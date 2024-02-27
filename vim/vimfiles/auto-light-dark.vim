
function! SetEverForestOptions()
	" Set contrast.
	" This configuration option should be placed before `colorscheme everforest`.
	" Available values: 'hard', 'medium'(default), 'soft'
	let g:everforest_background = 'medium'
	let g:everforest_better_performance = 0

	if has('gui_running')
		let g:everforest_transparent_background = 0
	else
		let g:everforest_transparent_background = 1
	endi

endfunction

function DarkMode()
	call SetEverForestOptions()
	colorscheme  dracula
	AirlineTheme dracula
	set background=dark
	call GuiConfig()
endfunction

function LightMode()
	call SetEverForestOptions()
	colorscheme everforest
	AirlineTheme everforest
	set background=dark
	call GuiConfig()
endfunction

