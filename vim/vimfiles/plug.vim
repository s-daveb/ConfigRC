filetype off

let s:plug_dir = '~/.vim-plug'

if has('nvim')
	let s:plug_dir = '~/.cache/nvim/plugged'
endif
call plug#begin(s:plug_dir)

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
if !has('nvim')
	Plug '/usr/local/opt/fzf'
	Plug 'junegunn/fzf.vim'
else
	Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -DCMAKE_C_COMPILER_LAUNCHER=ccache  -Bbuild -DCMAKE_BUILD_TYPE=Release -G Ninja && cmake --build build --config Release && cmake --install build --prefix build' }
endif

" No longer needed
"" Tmux integration
"Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'edkolev/tmuxline.vim'

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

if !has('nvim')
	Plug 's-daveb/vim-auto-light-dark'
else
	Plug 'f-person/auto-dark-mode.nvim' " Much faster!
endif

" HG integration
" Plug 'ludovicchabant/vim-lawrencium' " The profiler said this was SLOW.

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Project  Integration
if !has('nvim')
	Plug 's-daveb/vim-project'
else
	Plug 'ahmedkhalf/project.nvim'
endif

" Snippet Support
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'


" IDE-like features
Plug 'tpope/vim-dispatch'	" Integrated builds and error reporting
Plug 'epheien/termdbg' 		" Debugger integration

" Code Navigation
Plug 'liuchengxu/vista.vim'

if has('nvim')
	" Utilities - Required by many other neovim plugins
	Plug 'nvim-lua/plenary.nvim'            " Job control and more

	" Advanced syntax highlighting
	Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

	" UI frameworks
	Plug 'stevearc/dressing.nvim'           " Improves the default Neovim UI
	Plug 'folke/edgy.nvim'                  " Window management framework
	Plug 'MunifTanjim/nui.nvim'

	" Code Companion - Not technically an LSP,
	Plug 'olimorris/codecompanion.nvim'

	" IDE-like features
	Plug 'wojciech-kulik/xcodebuild.nvim'
	Plug 'mfussenegger/nvim-dap'
	Plug 'Civitasv/cmake-tools.nvim'

	" Highlights words the cursor rests on
	Plug 'tzachar/local-highlight.nvim'
endif

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

source $HOME/.vim/better-whitespace.vim
source $HOME/.vim/wordmotion.vim

source $HOME/.vim/netrw-conf.vim

source $HOME/.vim/cpp-modern-highlighting.vim

source $HOME/.vim/termdbg.vim
source $HOME/.vim/vista.vim
source $HOME/.vim/airline.vim

source $HOME/.vim/ui.vim
source $HOME/.vim/auto-light-dark.vim

source $HOME/.vim/tmux-navigator.vim


if has('nvim')
	source $HOME/.vim/vsnip.vim
	lua require('main-config').load()
else
	source $HOME/.vim/fzf.vim
	source $HOME/.vim/projects.vim
	source $HOME/.vim/async-lsp/main.vim
endif



" vim: set ts=4 sts=4 noet sw=4 foldmethod=marker foldmarker=@{,@} :
