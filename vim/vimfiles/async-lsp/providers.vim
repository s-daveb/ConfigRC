"Provider- Completion Source: TMUX
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
"end
"Provider- Completion Source: Ultisnips
if has('python3')
	let g:UltiSnipsExpandTrigger="<c-e>"
	au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'allowlist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif
"end
""Provider- Completion Source: Files
"" Blacklisted because it now autoregisters itself
let file_completor_opts = asyncomplete#sources#file#get_source_options({
    \ 'allowlist': ['*'],
    \ 'completor': function('asyncomplete#sources#file#completor'),
	\ 'priority': 10,
    \ })
"au User asyncomplete_setup call asyncomplete#register_source(l:file_completor_opts)
call asyncomplete#register_source(file_completor_opts)
"end
"Provider- Completion Source: VIM Omnicomplete
call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
			\ 'name': 'omni',
			\ 'allowlist': ['*'],
			\ 'blacklist': ['python', 'go', 'c', 'cpp', 'cpp.doxygen', 'h', 'hpp', 'objc', 'objcpp', 'cc' ],
			\ 'completor': function('asyncomplete#sources#omni#completor'),
			\ 'config': {
			\   'show_source_kind': 1,
			\ }
			\ }))
"end
"Provider- Completion Source: VIM Buffer Completion
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
			\ 'name': 'buffer',
			\ 'whitelist': ['*'],
			\ 'blacklist': ['python', 'go', 'c', 'cpp', 'cpp.doxygen', 'h', 'hpp', 'objc', 'objcpp', 'cc', 'vim'],
			\ 'completor': function('asyncomplete#sources#buffer#completor'),
			\ }))
"end
""Provider- Language Support: necovim
au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'necovim',
    \ 'allowlist': ['vim'],
    \ 'completor': function('asyncomplete#sources#necovim#completor'),
    \ })
"end
"Provider- Language Support: C/C++/Obj-C
let g:clangd_path = '/usr/bin/clangd'
if executable(g:clangd_path)
	augroup lsp_clangd
		autocmd!
		autocmd User lsp_setup call lsp#register_server({
					\ 'name': 'clangd',
					\ 'cmd': {server_info->
					\	[ g:clangd_path, '-j=6',
					\	  '--background-index',
					\     '--background-index-priority=background',
					\     '--clang-tidy',
					\     '--header-insertion=iwyu', '--header-insertion-decorators',
					\     '--function-arg-placeholders',
					\	  '--pch-storage=memory',
					\	]
					\ },
					\ 'whitelist': ['c', 'cpp', 'cpp.doxygen', 'objc', 'objcpp'],
					\ })
		autocmd FileType c setlocal omnifunc=lsp#complete
		autocmd FileType cpp setlocal omnifunc=lsp#complete
		autocmd FileType cpp.doxygen setlocal omnifunc=lsp#complete
		autocmd FileType objc setlocal omnifunc=lsp#complete
		autocmd FileType objcpp setlocal omnifunc=lsp#complete
	augroup end
endif
"end
"Provider- Language Support: CMake
if executable('cmake-language-server')
	" pip install python-language-server
	au User lsp_setup call lsp#register_server({
				\ 'name': 'cmake-language-server',
				\ 'cmd': {server_info->['cmake-language-server']},
				\ 'whitelist': ['cmake'],
				\ })
endif

"end
"Provider- Language Support: Javascript
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"end
"Provider- Language Support: Python3
if executable('pyls')
	" pip install python-language-server
	au User lsp_setup call lsp#register_server({
				\ 'name': 'pyls',
				\ 'cmd': {server_info->['pyls']},
				\ 'whitelist': ['python'],
				\ })
endif
"end
" vim: set foldmethod=marker foldmarker="Provider-,"end ts=4 sts=4 sw=4 noet :
