set preserveindent
set smartindent

set cindent
set cindent cinkeys-=0#

" Enable ack integration for FZF
let $FZF_DEFAULT_COMMAND='ack -f .'
"let $FZF_DEFAULT_COMMAND='find . -iname "*.*pp" -or -iname "*.hpp" -or -iname "*.c" -or -iname "*.h"'
let $FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if (&ft == 'c')
	nnoremap gh :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
endif

"source ~/.vim/vim-asynclsp/asynclsp.vim
"source ~/.vim/vim-asynclsp/providers.vim
source ~/.vim/vim-clang-format.py.vim
