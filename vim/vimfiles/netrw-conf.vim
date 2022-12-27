let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_liststyle = 3

map <silent> <C-E> :Lexplore<cr>

fu! NetrwKeyBindings()
	map <silent><buffer> gn :Ntree<cr>
endfunction

autocmd FileType netrw :call NetrwKeyBindings()
