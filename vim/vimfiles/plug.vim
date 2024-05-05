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
Plug 'mustache/vim-mustache-handlebars'
Plug 'bfrg/vim-cpp-modern'
Plug 'yump/vim-kerboscript'
Plug 'vim-scripts/applescript.vim'
Plug 'keith/swift.vim'
Plug 'cdelledonne/vim-cmake'
Plug 'richq/vim-cmake-completion'

" Command and Edit mode plugins
Plug 'tpope/vim-abolish'
Plug 'idanarye/breeze.vim'  " HTML navigation
Plug 'moll/vim-bbye' 		" buffer cleaner
"Plug 'takac/vim-hardtime' 	" Disables arrow keys  " This is an awful
Plug 'ntpeters/vim-better-whitespace' " Deletes trailing whitespace

" Better detect word boundaries
Plug 'chaoren/vim-wordmotion'

" File Management and searching plugins
Plug 'tpope/vim-vinegar' " Better Netrw config

" File searching plugins
Plug 'mileszs/ack.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" No longer needed
"" Tmux integration
"Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'

" Fancy status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color Themes
Plug 'lifepillar/vim-solarized8'
Plug 'crusoexia/vim-monokai'
Plug 'dracula/vim'
Plug 'sjl/badwolf'
Plug 'marciomazza/vim-brogrammer-theme'
Plug 'sainnhe/everforest'

" Color scheme switching
Plug 'xolox/vim-misc' 			" needed for vim-colorscheme-switcher
Plug 'xolox/vim-colorscheme-switcher'
Plug 'nburns/vim-auto-light-dark'

" Git/HG integration
Plug 'ludovicchabant/vim-lawrencium'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"
" Project tree Integration
Plug 's-daveb/vim-project'

" Snippet Support
if has('python3')
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
endif

" AutoComplete and IDE-like features
Plug 'tpope/vim-dispatch'	" Integrated builds and error reporting
Plug 'epheien/termdbg' 		" Debugger integration

" Code Navigation
"Plug 'preservim/tagbar'
Plug 'liuchengxu/vista.vim'

"  Load language server plugins
if !has('nvim')
	source $HOME/.vim/async-lsp/plug.vim
else
	source $HOME/.vim/nvim-lsp-plug.vim
endif

call plug#end()            " required
filetype plugin indent on  " required


""""""""""""""""""""""" PLUGIN CONFIG """""""""""""""""""""""""""""""

runtime macros/matchit.vim " for html % matching

source $HOME/.vim/help.vim
source $HOME/.vim/editorbehavior.vim

source $HOME/.vim/airline.vim
source $HOME/.vim/better-whitespace.vim
source $HOME/.vim/wordmotion.vim
source $HOME/.vim/tmux.compat.vim

source $HOME/.vim/netrw-conf.vim
source $HOME/.vim/projects.vim

source $HOME/.vim/cpp-modern-highlighting.vim

source $HOME/.vim/termdbg.vim
"source $HOME/.vim/tagbar.vim
source $HOME/.vim/vista.vim

source $HOME/.vim/ui.vim
source $HOME/.vim/auto-light-dark.vim

source $HOME/.vim/fzf.vim
source ${HOME}/.vim/copilot-settings.vim

if has('python3')
	source $HOME/.vim/UltiSnips.vim
endif

if has('nvim')
	lua require('nvim-config').load()
else
	source $HOME/.vim/async-lsp/main.vim
endif



