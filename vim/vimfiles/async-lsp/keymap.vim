
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

augroup AsyncMappings
autocmd BufRead,BufNewFile * if exists("*asyncomplete#_force_refresh")
"\ | echo "asyncomplete detected"
			\ | inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
			\ | inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
			\ | inoremap <expr> <cr>	pumvisible() ? asyncomplete#close_popup() : "\<cr>"
			\ | inoremap <buffer> <leader><tab> <Plug>(asyncomplete_force_refresh)
			\ | endif
augroup END

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

augroup LspMappings
" Check for vim-lsp being loaded before applying mappings
autocmd BufRead,BufNewFile * if exists("g:loaded_vlspa")
    \ | nnoremap <buffer> <silent> <leader>d :LspDocumentDiagnostics<CR>
    \ | nnoremap <buffer> <silent> <leader>n :LspNextError<CR>
    \ | nnoremap <buffer> <silent> <leader>b :LspPreviousError<CR>
    \ | nnoremap <buffer> <silent> <leader>q :LspStopServer<CR>
    \ | nnoremap <buffer> <silent> <leader>r :LspRename<CR>
    \ | nnoremap <buffer> <silent> <leader>] :LspDefinition<CR>
    \ | nnoremap <buffer> <silent> <leader>[ :LspDeclaration<CR>
    \ | nnoremap <buffer> <silent> <leader>ca :LspCodeAction<CR>
    \ | nnoremap <buffer> <silent> <leader>fix :LspCodeAction quickfix<CR>
    \ | nnoremap <buffer> <silent> <leader>h :LspHover<CR>
    \ | nnoremap <buffer> <silent> <leader>hint :call ToggleHints()<CR>
    \ | endif
augroup END



" vim: set ts=4 sts=4 noet sw=4 foldmethod=marker foldmarker=@{,@} :
