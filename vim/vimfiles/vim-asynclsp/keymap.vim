inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

nnoremap <buffer> lx :LspDocumentDiagnostics<CR>
nnoremap <buffer> <leader>x :LspDocumentDiagnostics<CR>

nnoremap <buffer> <leader>n :LspNextError<CR>
nnoremap <buffer> <leader>p :LspPreviousError<CR>
nnoremap <buffer> <leader>q  :LspStopServer<CR>

nnoremap <buffer> <leader>r :LspRename<CR>
nnoremap <buffer> <leader>] :LspDefinition<CR>
nnoremap <buffer> <leader>[ :LspDeclaration<CR>

nnoremap <buffer> <leader>f :LspCodeAction quickfix<CR>
