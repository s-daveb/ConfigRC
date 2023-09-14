
function! SetEverForestOptions()
	call ColorConfig()

    " Set contrast.
    " This configuration option should be placed before `colorscheme everforest`.
    " Available values: 'hard', 'medium'(default), 'soft'
    let g:everforest_background = 'hard'

    " For better performance
    let g:everforest_better_performance = 1
endfunction

function! DarkMode()
	let g:everforest_background='hard'
    set background=dark
	colorscheme everforest
	AirlineTheme everforest
	call GuiConfig()
endfunction

function! LightMode()
	let g:everforest_background='medium'
    set background=light
	colorscheme everforest
	AirlineTheme everforest
	call GuiConfig()
endfunction

