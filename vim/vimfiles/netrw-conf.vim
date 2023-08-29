let g:netrw_banner = 0
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4

if has("gui_running")
	let g:netrw_winsize = 25
else
	let g:netrw_winsize = 15
endif


map <silent> <leader><C-E> :Lexplore<cr>
map <silent> <C-E> :Lexplore %:p:h<cr>

fu! NetrwKeyBindings()
	map <silent><buffer> gn :Ntree<cr>
	map <silent><buffer><C-E> :close<cr>
endfunction

autocmd FileType netrw :call NetrwKeyBindings()
