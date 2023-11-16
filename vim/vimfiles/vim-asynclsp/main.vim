let g:asyncomplete_auto_popup = 1
let g:asyncomplete_remove_duplicates = 0

let g:asyncomplete_auto_completeopt=1
let g:asyncomplete_popup_delay=500

set completeopt=menuone,popup,noinsert,noselect,preview

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

let g:lsp_async_completion = 1

"  Enable disagnostics
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_document_highlight_enabled = 0

let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'} " icons require GUI
let g:lsp_signs_hint = {'text': '!?' } " icons require GUI


source ~/.vim/vim-asynclsp/lsp-settings.vim
source ~/.vim/vim-asynclsp/keymap.vim
source ~/.vim/vim-asynclsp/providers.vim

" for asyncomplete.vim log
"
"let g:lsp_log_verbose = 1
"let g:asyncomplete_log_file = expand('~/asyncomplete.log')

" vim:set et sts=0 sw=4 ts=4 tw=80:
