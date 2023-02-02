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



fu! TreeView()
	if &filetype != "netrw"
		if &columns > 110
 	   		let g:netrw_winsize = 25
			Lexplore
		elseif &columns > 80
 	   		let g:netrw_winsize = 20
			Lexplore
		else
 	   		let g:netrw_winsize = 20
			Sexplore
		endif
	endif
endfunction

map <silent> <C-E> :call TreeView()<cr>
fu! MapNtree()
	map <silent><buffer> gn    :Ntree<cr>
endfunction


autocmd FileType netrw :call MapNtree()
