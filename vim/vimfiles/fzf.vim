" Enable ack integration for FZF
let $FZF_DEFAULT_COMMAND='ack -f .'
let $FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

noremap <C-P> :FZF -i<CR>
