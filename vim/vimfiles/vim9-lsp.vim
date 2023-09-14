let lspServers = []

let lspOpts = #{
			\ autoHighlightDiags: v:true
			\}

let g:clangd_path = '/usr/bin/clangd'
if executable(g:clangd_path)
	let lspServers += [#{
				\    name: 'clangd',
				\    filetype: ['c', 'cpp', 'c.doxygen', 'cpp.doxygen'],
				\	 path: g:clangd_path,
				\    args: ['-j=2','--background-index', '--pch-storage=memory',
   				\  			'--limit-results=100', '--limit-references=100' ],
				\}]
endif

let g:pyls_path="/usr/local/bin/pyls"
if executable(g:pyls_path)
	let lspServers += [#{
				\    name: 'pyls',
				\    filetype: ['python'],
				\    path: g:pyls_path,
				\}]
endif


autocmd VimEnter * call LspAddServer(lspServers)
autocmd VimEnter * call LspOptionsSet(lspOpts)

" Enable omnicompletion for remaining filetypes
filetype plugin on
set omnifunc=syntaxcomplete#Complete
" vim : set ts=4 sts=4 noet sw=4 :
