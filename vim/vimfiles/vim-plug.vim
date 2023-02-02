filetype off

call plug#begin('~/.vim-plug')
" dependencies
Plug 'xolox/vim-misc'

" Filetypes
Plug 'tpope/vim-markdown'
"Plug 'hallison/vim-markdown'
Plug 'kchmck/vim-coffee-script'
Plug 'sjl/splice.vim'
Plug 'dag/vim-fish'
Plug 'LeonB/vim-nginx'
Plug 'pangloss/vim-javascript'
Plug 'skwp/vim-html-escape'
Plug 'keith/swift.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'octol/vim-cpp-enhanced-highlight'

" Command and Edit mode plugins
Plug 'tpope/vim-abolish'
Plug 'ntpeters/vim-better-whitespace'
Plug 'idanarye/breeze.vim'

Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'moll/vim-bbye' " buffer cleaner
Plug 'takac/vim-hardtime'

" Integrated builds and error reporting
Plug 'tpope/vim-dispatch'

" Better detect word boundaries
Plug 'chaoren/vim-wordmotion'

" File Management and searching plugins
Plug 'tpope/vim-vinegar' " Better Netrw config

" File searching plugins
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'justinmk/vim-dirvish'
Plug 'mileszs/ack.vim'

" Code Navigation
Plug 'preservim/tagbar'

" Tmux integration
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'

" Sexy status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colors
Plug 'spf13/vim-colors'
Plug 'altercation/vim-colors-solarized'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'sickill/vim-monokai'
Plug 'tomasr/molokai'
Plug 'dracula/vim'
Plug 'kitten/vim-adventurous'  " Dracula's baby
Plug 'sjl/badwolf'
Plug 'marciomazza/vim-brogrammer-theme'
Plug 'sainnhe/everforest'
Plug 's-daveb/vim-auto-light-dark'

" Git/HG integration
Plug 'ludovicchabant/vim-lawrencium'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 's-daveb/vim-project'
" Plug 'amiorin/vim-project' " Forked because it was ugly. Fixed syntax
" colors.

" Project Integration
Plug 'editorconfig/editorconfig-vim'

source $HOME/.vim/vim-asynclsp/plug.vim
"
" " All of your Plugs must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""" PLUGIN CONFIG """""""""""""""""""""""""""""""
"
source $HOME/.vim/colorscheme.switcher.vim
source $HOME/.vim/airline.vim
source $HOME/.vim/CtrlP.vim
source $HOME/.vim/better-whitespace.vim
source $HOME/.vim/hardtime.vim
source $HOME/.vim/tagbar.vim
source $HOME/.vim/tagbar.keys.vim
source $HOME/.vim/tmux.compat.vim
source $HOME/.vim/UltiSnips.vim
source $HOME/.vim/editorconfig.vim
source $HOME/.vim/netrw-conf.vim
source $HOME/.vim/projects.vim
source $HOME/.vim/vim-wordmotion.vim
source $HOME/.vim/vim-asynclsp/asynclsp.vim
source $HOME/.vim/auto-light-dark.vim

