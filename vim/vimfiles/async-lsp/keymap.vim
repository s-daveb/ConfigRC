inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>	pumvisible() ? asyncomplete#close_popup() : "\<cr>"

inoremap <buffer> <leader><tab> <Plug>(asyncomplete_force_refresh)

nnoremap <buffer> <leader>d :LspDocumentDiagnostics<CR>

nnoremap <buffer> <leader>n :LspNextError<CR>
nnoremap <buffer> <leader>b :LspPreviousError<CR>
nnoremap <buffer> <leader>q  :LspStopServer<CR>

nnoremap <buffer> <leader>r :LspRename<CR>
nnoremap <buffer> <leader>] :LspDefinition<CR>
nnoremap <buffer> <leader>[ :LspDeclaration<CR>

nnoremap <buffer> <leader>ca :LspCodeAction<CR>
nnoremap <buffer> <leader>fix :LspCodeAction quickfix<CR>

nnoremap <buffer> <leader>h :LspHover<CR>

function! ToggleHints()
	" Check if the flag exists and toggle its value
	if !exists('g:lsp_inlay_hints_enabled') || g:lsp_inlay_hints_enabled == 0
	echo "Enabling inlay hints"
		let g:lsp_inlay_hints_enabled = 1
	else
		echo "Disabling inlay hints"
		let g:lsp_inlay_hints_enabled = 0
	endif
endfunction

" Map <leader>hint to call the ToggleHints function
nnoremap <leader>hint :call ToggleHints()<CR>

" vim: set ts=4 sts=4 noet sw=4 foldmethod=marker foldmarker=@{,@} :
