inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

imap <c-r> <Plug>(asyncomplete_force_refresh)

nnoremap <buffer> lx :LspDocumentDiagnostics<CR>
nnoremap <buffer> <leader>x :LspDocumentDiagnostics<CR>

nnoremap <buffer> <leader>n :LspNextError<CR>
nnoremap <buffer> <leader>p :LspPreviousError<CR>
nnoremap <buffer> <leader>q  :LspStopServer<CR>

nnoremap <buffer> <leader>r :LspRename<CR>
nnoremap <buffer> <leader>] :LspDefinition<CR>
nnoremap <buffer> <leader>[ :LspDeclaration<CR>

nnoremap <buffer> <leader>f :LspCodeAction quickfix<CR>
nnoremap <buffer> <leader>? :LspHover<CR>
