
" Define the helper function
function! SendTerminalCommand(bufnr)
    let l:term_bufnr = a:bufnr
	let l:cmd1 = 'settings set frame-format frame #${frame.index}: ' .
				\ '${ansi.fg.yellow}${frame.pc}${ansi.normal}{ ${module.file.basename}{\${function.name-with-args}{${frame.no-debug}${function.pc-offset}}}}{ at ${ansi.fg.cyan}${line.file.fullpath}${ansi.normal}:${ansi.fg.yellow}${line.number}${ansi.normal}{:${ansi.fg.yellow}${line.column}${ansi.normal}}}{${function.is-optimized} [opt]}{${frame.is-artificial} [artificial]}\n'
	let l:cmd2 = 'settings set stop-line-count-before 0'
	let l:cmd3 = 'settings set stop-line-count-after 0'

	" Check if the terminal buffer's name is 'Terminal debugger'
    if bufname(l:term_bufnr) ==# 'Terminal debugger'
        " Send the command to the terminal buffer
        call term_sendkeys(l:term_bufnr, l:cmd1 . "\<CR>". l:cmd2 . "\<CR>" .
					\  l:cmd3 . "\<CR>")
    endif
endfunction

" Set up the autocmd to call the helper function when a Terminal window opens
autocmd TerminalOpen * call SendTerminalCommand(bufnr())
