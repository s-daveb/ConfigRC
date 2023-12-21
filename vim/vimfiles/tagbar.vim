" Tagbar Setup

let g:tagbar_zoomwidth=0 " zoom to largest sized tag
let g:tagbar_expand=0

function! SetTagbarWidth()
  	if &columns < 80
		" Set tagbar width to 20% (1/5) of winwidth, with min of 25
		let g:tagbar_width = max([10, winwidth(0) / 5])
	elseif &columns < 120
		let g:tagbar_width = max([25, winwidth(0) / 5])
  	else
    	let g:tagbar_width = 40
  	endif
endfunction

function! HandleResize()
	echo "HandleResize"
	TagbarToggle
	call SetTagbarWidth()
	TagbarToggle
endfunction

" Call SetTagbarWidth when the terminal is resized
autocmd BufWinEnter * call SetTagbarWidth()
autocmd VimResized * call HandleResize()

nmap <leader>tt :TagbarToggle<CR>
nmap <leader>tr :call SetTagbarWidth()<CR>

" vim:set noet sts=0 sw=4 ts=4 tw=80 :
