let g:asyncomplete_auto_popup = 1
let g:asyncomplete_remove_duplicates = 0

let g:asyncomplete_auto_completeopt=1
let g:asyncomplete_popup_delay=500

set completeopt=menuone,popup,noinsert,noselect,preview

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

source ~/.vim/async-lsp/lsp-settings.vim
source ~/.vim/async-lsp/keymap.vim
source ~/.vim/async-lsp/providers.vim

" for asyncomplete.vim log
"
"let g:lsp_log_verbose = 1
"let g:asyncomplete_log_file = expand('~/asyncomplete.log')

" vim:set et sts=0 sw=4 ts=4 tw=80:
