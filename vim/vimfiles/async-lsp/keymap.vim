inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

inoremap <buffer> <c-@> <Plug>(asyncomplete_force_refresh)
inoremap <buffer> <leader><tab> <Plug>(asyncomplete_force_refresh)

nnoremap <buffer> <leader>d :LspDocumentDiagnostics<CR>

nnoremap <buffer> <leader>n :LspNextError<CR>
nnoremap <buffer> <leader>b :LspPreviousError<CR>
nnoremap <buffer> <leader>q  :LspStopServer<CR>

nnoremap <buffer> <leader>r :LspRename<CR>
nnoremap <buffer> <leader>] :LspDefinition<CR>
nnoremap <buffer> <leader>[ :LspDeclaration<CR>

nnoremap <buffer> <leader>ca :LspCodeAction<CR>
nnoremap <buffer> <leader>h :LspHover<CR>
