" Base system
" ----------------
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 's-daveb/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Completion Sources
" ---------------
" Vim Script
Plug 'Shougo/neco-vim'
Plug 'prabirshrestha/asyncomplete-necovim.vim'

Plug 's-daveb/asyncomplete-file.vim'

"" For path completion and others
Plug 'yami-beta/asyncomplete-omni.vim'

"" Content from other VIM buffers
Plug 'prabirshrestha/asyncomplete-buffer.vim'

Plug 's-daveb/lsp-actions'

" Snippet support
" This is quite brittle
if has('python3')
	Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
endif

" vim: set ts=4 noet sw=4 sts=4 :
