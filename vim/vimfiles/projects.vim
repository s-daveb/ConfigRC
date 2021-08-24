
call project#rc("~/Developer")

Project 'Personal/ConfigRC', 				'configrc'
File	'Personal/ConfigRC/zsh/zshrc',   		'zshrc'
File	'Personal/ConfigRC/vim/vimrc',          	'vimrc'
File	'Personal/ConfigRC/vim/vimfiles/vim-plug.vim',	'vim-plug'
File	'Personal/ConfigRC/vim/vimfiles/vim-asynclsp/asynclsp.vim', 'vim-asynclsp'
"
let qw_path="Personal/C++/Projects/quartz-warriors"
"
Project qw_path 				, 'quartz-warriors'
File	qw_path . '/src/main.cpp' 		, 'qw/main'
File	qw_path . '/Makefile.am'		, 'qw/Makefile.am'
File	qw_path . '/src/tests/Makefile.am'	, 'qw/tests/Makefile.am'
Callback 'quartz-warriors'			, 'SetUpQW'
"
function! SetUpQW(title) abort
	source ~/.vim/projects.d/quartz-warriors.vimrc
endfunction
