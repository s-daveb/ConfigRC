
" Automatic completion.
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_min_chars = 3
let g:asyncomplete_popup_delay = 500
"let g:asyncomplete_auto_completeopt=1

set completeopt=menuone,popup,noinsert,noselect,preview

let g:lsp_auto_enable = 1
let g:lsp_async_completion = 1
let g:lsp_use_native_client = 1  " Use VIM's native LSP client

" Highlighting Improvements
let g:lsp_semantic_enabled = 1  " Enable semantic highlighting
let g:lsp_document_highlight_enabled = 1  " Highlight reference under cursor

" inlay hints settings
let g:lsp_inlay_hints_enabled = 1         " Add hints
let g:lsp_inlay_hints_mode = {
\ 'normal' : [ 'curline' ],
\ 'insert' : [ 'force', '!curline' ],
\ }
let g:lsp_document_code_action_signs_hint = {"text": "⚙️ "}

"  Enable disagnostics
let g:lsp_diagnostics_enabled = 1

let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 1
let g:lsp_diagnostics_virtual_text_prefix = "^"
let g:lsp_diagnostics_virtual_text_padding_left = 1
let g:lsp_diagnostics_virtual_text_align = "below"

let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_signs_error = {"text": "✘" }
let g:lsp_diagnostics_signs_warning = {"text": "⚠️" }
let g:lsp_diagnostics_signs_hint = {"text": "💡"}

let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_diagnostics_highlight_enabled = 1



" vim:set ts=2 sts=2 sw=2 noet:
