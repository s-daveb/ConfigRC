" Tagbar Setup

function! SetTagbarWidth()
  	if winwidth(0) < 81
		" Set tagbar width to 20% (1/5) of winwidth, with min of 25
		let g:tagbar_width = max([25, winwidth(0) / 5])
  	else
    	let g:tagbar_width = 40
  	endif

 	" Check if a window named "tagbar.vim" exists and resize it
  	"let l:tagbar_window = bufwinnr('tagbar.vim')
  	"if l:tagbar_window != -1
	"	let g:tagbar_expand=0
	"	TagbarClose
	"	TagbarOpen
	"	let g:tagbar_expand=1
  	"endif
endfunction

" Call SetTagbarWidth when Vim starts
autocmd GuiEnter * call SetTagbarWidth()

" Call SetTagbarWidth when the terminal is resized
autocmd VimResized * call SetTagbarWidth()

let g:tagbar_zoomwidth=0 " zoom to largest sized tag
let g:tagbar_expand=1

nmap <leader>tt :TagbarToggle fj<CR>
nmap <leader>tb :TagbarOpen fj<CR>

" vim:set noet sts=0 sw=4 ts=4 tw=80 :
