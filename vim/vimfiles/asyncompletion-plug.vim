" Base system
" ----------------
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'

" Completion Sources
" ---------------
" Vim Script
Plug 'Shougo/neco-vim'
Plug 'prabirshrestha/asyncomplete-necovim.vim'

" Broken: URL-like constructions make VIM hang
"Plug 'prabirshrestha/asyncomplete-file.vim'

" For path completion and others
Plug 'yami-beta/asyncomplete-omni.vim'


" Content from other VIM buffers
Plug 'prabirshrestha/asyncomplete-buffer.vim'

" because I can't stop getting new plugins
Plug 'wellle/tmux-complete.vim'

" Snippet support
" This is quite brittle
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
" vim:set et sts=0 sw=4 ts=4 tw=80:
