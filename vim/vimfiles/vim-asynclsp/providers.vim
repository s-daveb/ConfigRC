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

let g:clangd_path = '/usr/bin/clangd'
if executable(g:clangd_path)
	augroup lsp_clangd
		autocmd!
		autocmd User lsp_setup call lsp#register_server({
					\ 'name': 'clangd',
					\ 'cmd': {server_info->
					\ [ g:clangd_path,
					\ '-j=2','--background-index', '--pch-storage=memory',
 				   	\  '--limit-results=100', '--limit-references=100' ]},
					\ 'whitelist': ['c', 'cpp', 'cpp.doxygen', 'objc', 'objcpp'],
					\ })
"  '--header-insertion=never', '--all-scopes-completion',
		autocmd FileType c setlocal omnifunc=lsp#complete
		autocmd FileType cpp setlocal omnifunc=lsp#complete
		autocmd FileType cpp.doxygen setlocal omnifunc=lsp#complete
		autocmd FileType objc setlocal omnifunc=lsp#complete
		autocmd FileType objcpp setlocal omnifunc=lsp#complete
	augroup end
endif

if has('python3')
    let g:UltiSnipsExpandTrigger="<c-e>"
	call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
			    \ 'name': 'ultisnips',
				\ 'allowlist': ['*'],
				\ 'completor': function('asyncomplete#sources#ultisnips#completor'),
				\ }))
endif

" Blacklisted because it's buggy - anything that looks like a URL makes VIM hang
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
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
