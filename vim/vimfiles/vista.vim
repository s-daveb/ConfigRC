
" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'

let g:vista_ctags_executable = "/usr/local/bin/ctags"

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
"let g:vista_executive_for = {
"  \ 'cpp': [ 'vim_lsp', 'nvim_lsp' ],
"  \ 'cpp.doxygen': [ 'vim_lsp', 'nvim_lsp'],
"  \ 'c': [ 'vim_lsp', 'nvim_lsp'],
"  \ 'c.doxygen': [ 'vim_lsp', 'nvim_lsp'],
"  \ }

if has('nvim')
	let g:vista_default_executive='nvim_lsp'
else
	let g:vista_default_executive='vim_lsp'
endif

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\    'class': "ℂ{}",
\    'func': "𝒇()",
\    'function': "𝒇()",
\    'functions': "𝒇()",
\    'var': "𝓧𝒴𝑍",
\    'field': "𝓧𝒴𝑍",
\    'variable': "𝓧𝒴𝑍",
\    'variables': "𝓧𝒴𝑍",
\    'const': "🔒",
\    'constant': "🔒",
\    'constructor': "🛠️",
\    'method': "𝑭()",
\    'package': "📦",
\    'packages': "📦",
\    'enum': "🚩",
\    'enummember': "◦",
\    'enumerator': "𝑬",
\    'module': "{}",
\    'modules': "{}",
\    'type': "T",
\    'typedef': ":=",
\    'macro': "⚙️",
\    'macros': "⚙️",
\    'map': "#:",
\    'augroup': "au",
\    'struct': "ς{}",
\    'union': "\Uf0564",
\    'member': "\uf02b",
\    'target': "\Uf0394",
\    'property': "\ueb65",
\    'interface': "\ueb61",
\    'namespace': "{}",
\    'subroutine': "ς",
\    'implementation': "𝐼{}",
\    'typeParameter': "<T>",
\    'default': "‣"
\}

" >>>> Vista Dynamic Resizing functions <<<<  {
let g:usable_width =  &columns

function! UpdateUsableWidth()
	let g:usable_width =  &columns - g:vista_sidebar_width
endfunction

function! IsVistaWindowDisplayed() abort
    " Get a list of all window IDs
    let l:win_ids = range(1, winnr('$'))
    let l:win_ids = map(l:win_ids, 'win_getid(v:val)')

    " Loop through all window IDs
    for l:win_id in l:win_ids
        " Get the buffer number for the window
        let l:bufnr = winbufnr(l:win_id)

        " Get the filetype of the buffer
        let l:filetype = getbufvar(l:bufnr, '&filetype')

        " Check if the filetype of the buffer is 'Vista'
        if l:filetype == 'vista_kind'
            return 1
        endif
    endfor

    return 0
endfunction


function! OpenVista()
	if g:usable_width > 60
		Vista
	else
		Vista!
		echo "Not enough screen space for Vista!"
	endif
endfunction


function! ToggleVista()
	let l:is_open = IsVistaWindowDisplayed()
	if l:is_open == 1
		Vista!
	else
		Vista
	endif
endfunction

function! ResizeVista()
	let l:reopen = 0
	let l:is_open = IsVistaWindowDisplayed()

	if l:is_open == 1
		Vista!
		let l:reopen = 1
	endif

	call UpdateUsableWidth()
	if (g:usable_width > 40) && (g:usable_width < 120)
		let g:vista_sidebar_width = max([15,winwidth(0) / 4])
  	else
    	let g:vista_sidebar_width = 50
  	endif
	call UpdateUsableWidth()
	if l:reopen != 0
		 call OpenVista()
	endif
endfunction

autocmd VimEnter *.cpp,*.hpp,*.c,*.h call vista#RunForNearestMethodOrFunction()

" Call ResizeVista when the terminal is resized
"autocmd BufWinEnter * call ResizeVista()
"autocmd VimResized * call ResizeVista()

nmap <silent> <leader>tt :call ToggleVista()<CR>
nmap <silent> <leader>tr :call ResizeVista()<CR>


" vim: set ts=4 sts=4 noet sw=4 foldmethod=marker foldmarker={,} foldminlines=10 :
