"Airline settings

let g:airline_powerline_fonts=1
"let g:airline_theme =  "badwolf"

let g:airline#extensions#whitespace#enabled = 0
"let g:airline#extensions#whitespace#mixed_indent_algo = 2
"let g:airline#extensions#whitespace#symbol = '.'

"let g:airline#extensions#netrw#enabled = 1
"let g:airline#extensions#tmuxline#enabled = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline#extensions#tabline#show_splits = 1

set laststatus=2
set encoding=utf8

function! AirlineInit()
"	let g:airline_section_a = airline#section#create( ['mode',' ','branch'])
"	let g:airline_section_b = airline#section#create_left(['ffenc', 'hunks', '%f' ])
"	let g:airline_section_c = airline#section#create( ['filetype'])
"	let g:airline_section_x = airline#section#create( ['%P' ])
"	let g:airline_section_y = airline#section#create(['%B'])
"	let g:airline_section_z = airline#section#create_right(['%l', '%c'])
	AirlineRefresh
endfunction

au VimEnter * call AirlineInit()
