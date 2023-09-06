
" before call project#rc()
let g:project_enable_welcome = 0
call project#rc("~/Developer")

function! LoadLocalConfig(title)
	source ~/.vim/projects.d/load-local.vimrc
endfunction
