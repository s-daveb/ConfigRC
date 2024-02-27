

let g:asyncomplete_enable_for_all = 1

" Automatic completion.
let g:asyncomplete_auto_popup = 0
let g:asyncomplete_min_chars = 2
"let g:asyncomplete_popup_delay = 30
let g:asyncomplete_auto_completeopt=0

set completeopt=menuone,popup,noinsert,noselect,preview

source ~/.vim/async-lsp/keymap.vim
source ~/.vim/async-lsp/lsp-settings.vim
source ~/.vim/async-lsp/providers.vim

" for asyncomplete.vim log
"
"let g:lsp_log_verbose = 1
"let g:asyncomplete_log_file = expand('~/asyncomplete.log')

" vim:set et sts=0 sw=4 ts=4 tw=80:
