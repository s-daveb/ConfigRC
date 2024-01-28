
" before call project#rc()
let g:project_enable_welcome = 1
set rtp+=~/.vim/bundle/vim-project/

call project#rc("~/Developer")

Project 'scratch'

Project 'ConfigRC' 				, 'configrc'
File	'ConfigRC/zsh/zshrc'			, 'zshrc'
File	'ConfigRC/vim/vimrc'			, 'vimrc'
File	'ConfigRC/vim/vimfiles/plug.vim'	, 'vim-plug'
File	'ConfigRC/vim/vimfiles/async-lsp'    	, 'vim-asynclsp folder'

let qw_path='C++/quartz-warriors'
Project qw_path					, 'quartz-warriors'
File	qw_path . '/CMakeLists.txt'		, 'qw/CMakeLists.txt'
Callback 'quartz-warriors'			, 'LoadLocalConfig'

let cgi_path="C++/mdml-cgi"
Project cgi_path 				, 'mdml-cgi'
File 	cgi_path . '/CMakeLists.txt'		, 'mdml/CMakeLists'
Callback 'mdml-cgi', 	'LoadLocalConfig'


let elemental_path="C++/elemental-game"
Project elemental_path 				, 'elemental'
File elemental_path . '/CMakeLists.txt'		, 'elemental/CMakeLists'
Callback 'elemental'				, 'LoadLocalConfig'

function! LoadLocalConfig(title)
	source ~/.vim/projects.d/load-local.vimrc
endfunction
