let g:netrw_banner = 0
let g:netrw_altv = 1

let g:netrw_preview = 1
let g:netrw_liststyle = 3

let g:netrw_usetab = 1

set wildignore='.*,.DS_Store'

if !exists('gui_vimr')
	let g:netrw_wiw = 15
	let g:netrw_winsize = 20

	map <silent> <C-E> :Lexplore<CR>

	fu! NetrwKeyBindings()
		map <silent><buffer> gn :Ntree<CR>
		map <silent><buffer><C-E> :close<CR>
	endfunction

	autocmd FileType netrw :call NetrwKeyBindings()
endif
