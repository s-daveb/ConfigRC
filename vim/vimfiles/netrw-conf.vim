let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_liststyle = 3


let gitignore = netrw_gitignore#Hide()

" HIde dot files
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
if !(empty(gitignore)) && !(filereadable("configure.ac"))
	let g:netrw_list_hide = g:netrw_list_hide . ',' .  gitignore
endif

let g:netrw_hide = 1
unlet gitignore
"unlet g:netrw_list_hide

"if &columns > 110 | let g:netrw_winsize = 25 | else | let g:netrw_winsize = 15 | endif
let g:netrw_winsize = 10

map <silent> <C-E> :Lexplore<cr>

"autocmd FileType cpp :Lexplore

fu! MapNtree()
	map <silent><buffer> gn    :Ntree<cr>
endfunction

autocmd FileType netrw :call MapNtree()
