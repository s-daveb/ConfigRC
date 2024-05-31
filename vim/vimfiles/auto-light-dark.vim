
let s:selected_dark_color="dracula"
let s:selected_light_color="dracula"


let iterm_profile = getenv("ITERM_PROFILE")

if iterm_profile && iterm_profile != "ITERM_PROFILE"  || has("gui_running")
	let s:selected_dark_color="everforest"
	let s:selected_light_color="everforest"
endif

function! SetEverForestOptions()
	" Set contrast.
	" This configuration option should be placed before `colorscheme everforest`.
	" Available values: 'hard', 'medium'(default), 'soft'
	let g:everforest_background = 'medium'
	let g:everforest_better_performance = 1

	if has('gui_running')
		let g:everforest_transparent_background = 0
	else
		let g:everforest_transparent_background = 1
	endif

endfunction

function DarkMode()
	if (s:selected_dark_color == "everforest")
		call SetEverForestOptions()
		set background=dark
	endif

	execute "colorscheme " . s:selected_dark_color
	execute "AirlineTheme " . s:selected_dark_color
	call GuiConfig()
endfunction

function LightMode()
	if (s:selected_light_color == "everforest")
		call SetEverForestOptions()
		set background=light
	endif
	execute "colorscheme " . s:selected_light_color
	execute "AirlineTheme " . s:selected_light_color

	call GuiConfig()
endfunction

" vim: set ts=4 sts=4 noet sw=4 foldmethod=marker foldmarker=@{,@} :
