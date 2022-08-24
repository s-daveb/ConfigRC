"ctrlp setup
let g:ctrlp_show_hidden = 1
let g:ctrlp_user_command = {
			\'types': {
			\ 1: ['.git', 'cd %s && git ls-files -co --exclude-standard'],
			\ },
			\ 'fallback': '[[ "x$PWD" == "x$HOME" ]] && echo "" || ag %s ""'
			\}
let g:ctrlp_switch_buffer = 'e'

let g:ctrlp_open_multiple_files='2hjr'

" vim:set noet sts=0 sw=4 ts=4 tw=4:
