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

"" Broken: URL-like constructions make VIM hang (??)
"Plug 'prabirshrestha/asyncomplete-file.vim'

"" For path completion and others
Plug 'yami-beta/asyncomplete-omni.vim'

"" Content from other VIM buffers
Plug 'prabirshrestha/asyncomplete-buffer.vim'

Plug 's-daveb/lsp-actions'

" Snippet support
" This is quite brittle
if has('python3')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
endif

source $HOME/.vim/UltiSnips.vim
