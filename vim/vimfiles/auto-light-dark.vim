
function! SetEverForestOptions()
	if has('termguicolors')
        set termguicolors
    endif

    " Set contrast.
    " This configuration option should be placed before `colorscheme everforest`.
    " Available values: 'hard', 'medium'(default), 'soft'
    let g:everforest_background = 'soft'

    " For better performance
    let g:everforest_better_performance = 1
endfunction

function! DarkMode()
	let g:everforest_background='hard'
    #set background=dark
	colorscheme dracula
	AirlineTheme dracula
	call GuiConfig()
endfunction

function! LightMode()
	let g:everforest_background='medium'
    #set background=light
	colorscheme dracula
	AirlineTheme dracula
	call GuiConfig()
endfunction

