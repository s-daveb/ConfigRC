" Enable ack integration for FZF
let $FZF_DEFAULT_COMMAND='ack --ignore-dir=vim-debug --ignore-dir=docs --ignore-dir=data -f .'
"let $FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


augroup fzfMappings
    autocmd!

    " Run this autocommand for every file type you consider a source file
    autocmd BufRead,BufNewFile * if exists("g:loaded_fzf_vim")
        \ | nnoremap <buffer> <silent> <leader>open :Files<CR>
        \ | nnoremap <buffer> <silent> <leader>comm :Commits<CR>
        \ | nnoremap <buffer> <silent> <leader>gfiles :GFiles<CR>
        \ | nnoremap <buffer> <silent> <leader>gstat :GFiles?<CR>
        \ | nnoremap <buffer> <silent> <leader>lines :Lines<CR>
        \ | nnoremap <buffer> <silent> <leader>help :Helptags<CR>
        \ | nnoremap <buffer> <C-P> :Files<CR>
        \ | nnoremap <buffer> <C-P>B :Buffers<CR>
    \ | endif
augroup END

set hidden
