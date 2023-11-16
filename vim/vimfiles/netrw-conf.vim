let g:netrw_banner = 0
let g:netrw_altv = 1

let g:netrw_preview = 1
let g:netrw_liststyle = 3
let g:netrw_winsize = 30

let g:netrw_usetab = 1
let g:netrw_wiw = 15

map <silent> <leader><C-E> :Lexplore<cr>
map <silent> <C-E> :Lexplore %:p:h<cr>

fu! NetrwKeyBindings()
	map <silent><buffer> gn :Ntree<cr>
	map <silent><buffer><C-E> :close<cr>
endfunction

autocmd FileType netrw :call NetrwKeyBindings()
