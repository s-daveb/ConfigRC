
call project#rc("~/Developer")

Project 'Downloads/Github/ConfigRC', 				'configrc'
File	'Downloads/Github/ConfigRC/zsh/zshrc',   		'zshrc'
File	'Downloads/Github/ConfigRC/vim/vimrc',          	'vimrc'
File	'Downloads/Github/ConfigRC/vim/vimfiles/vim-plug.vim',	'vim-plug'
File	'Downloads/Github/ConfigRC/vim/vimfiles/vim-asynclsp/asynclsp.vim', 'vim-asynclsp'

function! LoadLocalConfig(title)
	source ~/.vim/projects.d/load-local.vimrc
endfunction
