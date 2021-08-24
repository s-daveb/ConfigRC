if executable('pyls')
	" pip install python-language-server
	au User lsp_setup call lsp#register_server({
				\ 'name': 'pyls',
				\ 'cmd': {server_info->['pyls']},
				\ 'whitelist': ['python'],
				\ })
endif


let g:tmuxcomplete#asyncomplete_source_options = {
			\ 'name':      'tmuxcomplete',
			\ 'whitelist': ['*'],
			\ 'blacklist': ['python', 'go', 'c', 'c.doxygen', 'cpp','cpp.doxygen', 'objc', 'objcpp', 'cc'],
			\ 'config': {
			\     'splitmode':      'words',
			\     'filter_prefix':   1,
			\     'show_incomplete': 1,
			\     'sort_candidates': 0,
			\     'scrollback':      0,
			\     'truncate':        0
			\     },
			\ }
let g:clangd_path = '/Library/Developer/CommandLineTools/usr/bin/clangd'

if executable(g:clangd_path)
	augroup lsp_clangd
		autocmd!
		autocmd User lsp_setup call lsp#register_server({
					\ 'name': 'clangd',
					\ 'cmd': {server_info->[g:clangd_path, '--background-index', '--suggest-missing-includes', '-j=2']},
					\ 'whitelist': ['c', 'cpp', 'cpp.doxygen', 'objc', 'objcpp'],
					\ })
		autocmd FileType c setlocal omnifunc=lsp#complete
		autocmd FileType cpp setlocal omnifunc=lsp#complete
		autocmd FileType cpp.doxygen setlocal omnifunc=lsp#complete
		autocmd FileType objc setlocal omnifunc=lsp#complete
		autocmd FileType objcpp setlocal omnifunc=lsp#complete
	augroup end
endif


" Blacklisted because it's buggy - anything that looks like a URL makes VIM hang
"au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
"    \ 'name': 'file',
"    \ 'whitelist': ['*'],
"    \ 'completor': function('asyncomplete#sources#file#completor')
"    \ }))
"
call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
			\ 'name': 'omni',
			\ 'allowlist': ['*'],
			\ 'blocklist': ['vim', 'xml', 'html'],
			\ 'completor': function('asyncomplete#sources#omni#completor'),
			\ 'config': {
			\   'show_source_kind': 1,
			\ }
			\ }))

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
			\ 'name': 'buffer',
			\ 'whitelist': ['*'],
			\ 'blacklist': ['python', 'go', 'c', 'cpp', 'cpp.doxygen', 'h', 'hpp', 'objc', 'objcpp', 'cc', 'vim'],
			\ 'completor': function('asyncomplete#sources#buffer#completor'),
			\ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
			\ 'name': 'necovim',
			\ 'whitelist': ['vim'],
			\ 'completor': function('asyncomplete#sources#necovim#completor'),
			\ }))


autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"
if has('python3')
	let g:UltiSnipsExpandTrigger="<c-l>"
	let g:UltiSnipsJumpForwardTrigger="<c-j>"
	let g:UltiSnipsJumpBackwardTrigger="<c-k>"

	call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
				\ 'name': 'ultisnips',
				\ 'whitelist': ['*'],
				\ 'completor': function('asyncomplete#sources#ultisnips#completor'),
				\ }))
endif


" vim:set noet sts=2 sw=8 ts=2 tw=80:
