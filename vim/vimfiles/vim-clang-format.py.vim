
let s:formatting = 0

nnoremap <C-K><c-f> :py3f /usr/local/share/clang/clang-format.py<CR>

function FormatBuffer()
  	let s:formatting = 1

  	if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    	let cursor_pos = getpos('.')
    	:silent %!clang-format
    	call setpos('.', cursor_pos)
  	endif

  	let s:formatting = 0
endfunction

autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call FormatBuffer()
