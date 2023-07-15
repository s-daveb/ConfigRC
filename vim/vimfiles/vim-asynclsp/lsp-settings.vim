
let g:lsp_settings_enable_suggestions = 0

let g:lsp_settings_root_markers = [
			\   '.git',
			\   '.git/',
			\   '.svn',
			\   '.hg',
			\   '.bzr',
			\   '.npmrc'
			\ ]

"let g:my_lsp_diagnostics_enabled = 0

"function s:MyToggleLSPDiagnostics()
"    if g:my_lsp_diagnostics_enabled == 1
"        call lsp#disable_diagnostics_for_buffer()
"        let g:my_lsp_diagnostics_enabled = 0
"        echo "LSP Diagnostics : off"
"    else
"        call lsp#enable_diagnostics_for_buffer()
"        let g:my_lsp_diagnostics_enabled = 1
"        echo "LSP Diagnostics : on"
"    endif
"endfunction
"
"command MyToggleLSPDiagnostics call s:MyToggleLSPDiagnostics()
"
"nnoremap <F12> :MyToggleLSPDiagnostics<CR>
nnoremap <F12> :LspDocumentDiagnostics<CR>


let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/lsp.log')
"
" for asyncomplete.vim log
let g:asyncomplete_log_file = expand('~/asyncomplete.log')

" vim:set ts=2 sts=2 sw=2 noet:
