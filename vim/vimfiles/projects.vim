
" before call project#rc()
let g:project_enable_welcome = 0
call project#rc("~/Developer")

Project 'Personal/ConfigRC', 				'configrc'
File	'Personal/ConfigRC/zsh/zshrc',   		'zshrc'
File	'Personal/ConfigRC/vim/vimrc',          	'vimrc'
File	'Personal/ConfigRC/vim/vimfiles/vim-plug.vim',	'vim-plug'
File	'Personal/ConfigRC/vim/vimfiles/vim-asynclsp/asynclsp.vim', 'vim-asynclsp'

let game_path="Personal/C++/Ascendent"
Project game_path 				, 'Ascendent'
File	game_path . '/src/main.cpp' 		, 'game/main'
File	game_path . '/Makefile.am'		, 'game/Makefile.am'
File	game_path . '/src/tests/Makefile.am'	, 'game/tests/Makefile.am'
Callback 'Ascendent'			, 'LoadLocalConfig'

let qw_path="Personal/C++/quartz-warriors"

Project qw_path 				, 'quartz-warriors'
File	qw_path . '/src/main.cpp' 		, 'qw/main'
File	qw_path . '/Makefile.am'		, 'qw/Makefile.am'
File	qw_path . '/src/tests/Makefile.am'	, 'qw/tests/Makefile.am'
Callback 'quartz-warriors'			, 'LoadLocalConfig'

let cgi_path="Personal/C++/mdml-cgi"
Project cgi_path 				, 'mdml-cgi'
File 	cgi_path . 'CMakeLists.txt', 'mdml/CMakeLists'
Callback 'mdml-cgi', 	'LoadLocalConfig'

function! LoadLocalConfig(title)
	source ~/.vim/projects.d/load-local.vimrc
endfunction
