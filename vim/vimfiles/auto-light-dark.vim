
let s:selected_dark_colo="everforest"
let s:selected_light_colo="everforest"

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
	endif

endfunction

function DarkMode()
	if (s:selected_dark_colo == "everforest")
		call SetEverForestOptions()
	endif
	execute "colorscheme " . s:selected_dark_colo
	execute "AirlineTheme " . s:selected_dark_colo
	set background=dark
	call GuiConfig()
endfunction

function LightMode()
	call SetEverForestOptions()
	execute "colorscheme " . s:selected_light_colo
	execute "AirlineTheme " . s:selected_light_colo

	set background=light
	call GuiConfig()
endfunction

