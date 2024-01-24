filetype off

call plug#begin('~/.vim-plug')

" Filetypes
Plug 'tpope/vim-markdown'
Plug 'kchmck/vim-coffee-script'
Plug 'sjl/splice.vim'
Plug 'dag/vim-fish'
Plug 'LeonB/vim-nginx'
Plug 'pangloss/vim-javascript'
Plug 'skwp/vim-html-escape'
Plug 'keith/swift.vim'
Plug 'mustache/vim-mustache-handlebars'
"Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'bfrg/vim-cpp-modern'
"Plug 'vim-scripts/User-Defined-Type-Highlighter'
Plug 'yump/vim-kerboscript'
Plug 'vim-scripts/applescript.vim'

" Command and Edit mode plugins
Plug 'tpope/vim-abolish'
Plug 'idanarye/breeze.vim'  " HTML navigation
Plug 'moll/vim-bbye' 		" buffer cleaner
"Plug 'takac/vim-hardtime' 	" Disables arrow keys  " This is an awful
"plugin
Plug 'ntpeters/vim-better-whitespace' " Deletes trailing whitespace


" Better detect word boundaries
Plug 'chaoren/vim-wordmotion'

" File Management and searching plugins
Plug 'tpope/vim-vinegar' " Better Netrw config

" File searching plugins
Plug 'mileszs/ack.vim'
Plug '/usr/local/opt/fzf'

" No longer needed
"" Tmux integration
"Plug 'benmills/vimux'
"Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'

" Fancy status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color Themes
Plug 'lifepillar/vim-solarized8'
"Plug 'altercation/vim-colors-solarized'
"Plug 'sickill/vim-monokai'
Plug 'crusoexia/vim-monokai'
"Plug 'tomasr/molokai'
Plug 'dracula/vim'
"Plug 'kitten/vim-adventurous'  " Dracula's baby
Plug 'sjl/badwolf'
Plug 'marciomazza/vim-brogrammer-theme'
Plug 'sainnhe/everforest'

" Color scheme switching
Plug 'xolox/vim-misc' 					" needed for vim-colorscheme-switcher
Plug 'xolox/vim-colorscheme-switcher'
Plug 'nburns/vim-auto-light-dark'

" Git/HG integration
Plug 'ludovicchabant/vim-lawrencium'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"
" Project tree Integration
Plug 'amiorin/vim-project'

" Snippet Support
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" AutoComplete and IDE-like features
Plug 'tpope/vim-dispatch'	" Integrated builds and error reporting
Plug 'epheien/termdbg' 		" Debugger integration
Plug 'rhysd/vim-clang-format'
"
source $HOME/.vim/vim-asynclsp/plug.vim

" Code Navigation
Plug 'preservim/tagbar'

" All of your Plugs must be added before the following line
call plug#end()            " required
filetype plugin indent on  " required
""""""""""""""""""""""" PLUGIN CONFIG """""""""""""""""""""""""""""""

runtime macros/matchit.vim " for html % matching

source $HOME/.vim/help.vim
source $HOME/.vim/editorbehavior.vim
source $HOME/.vim/ui.vim

source $HOME/.vim/airline.vim
source $HOME/.vim/better-whitespace.vim
source $HOME/.vim/hardtime.vim
source $HOME/.vim/vim-wordmotion.vim
source $HOME/.vim/tmux.compat.vim

source $HOME/.vim/netrw-conf.vim
source $HOME/.vim/projects.vim
source $HOME/.vim/fzf.vim

source $HOME/.vim/colorscheme.switcher.vim
source $HOME/.vim/auto-light-dark.vim
source $HOME/.vim/cpp-modern-highlighting.vim
source $HOME/.vim/clang-format.vim

source $HOME/.vim/termdbg.vim
source $HOME/.vim/vim-asynclsp/main.vim
"source $HOME/.vim/vim9-lsp.vim
source $HOME/.vim/tagbar.vim
