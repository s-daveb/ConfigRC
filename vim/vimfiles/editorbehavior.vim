" for sh shell
let g:is_posix=1

set directory=$HOME/.cache/vim/swap/
set viewdir=$HOME/.cache/vim/view

set undofile
set undodir=$HOME/.cache/vim/undo/
set undolevels=1000
set undoreload=10000

set modeline

set tagrelative
set tags=./build/tags,./tags;

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,n~/.viminfo

function! FileOffset()
    echo line2byte(line('.')) + col('.') - 1
endfunction

set viewoptions-=options
set splitbelow

autocmd BufLeave *.* mkview!
autocmd BufEnter *.* silent loadview

autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview

syntax on

function! RepeatChar(char, count)
	return repeat(a:char, a:count)
endfunction

"autocmd FileType qf wincmd J

nnoremap s :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>

function! WriteRandomNum()
 r! dd if=/dev/urandom count=4 bs=1 2> /dev/null | od -D | awk '{ print $2 }'
endfunction

command WriteRandom call WriteRandomNum()
nnoremap <leader>rand :WriteRandom<CR>

" # Function to permanently delete views created by 'mkview'
function! MyDeleteView()
  let path = fnamemodify(bufname('%'),':p')
  " vim's odd =~ escaping for /
  let path = substitute(path, '=', '==', 'g')
  if empty($HOME)
  else
      let path = substitute(path, '^'.$HOME, '\~', '')
  endif
  let path = substitute(path, '/', '=+', 'g') . '='
  " view directory
  let path = &viewdir.'/'.path
  call delete(path)
  echo "Deleted: ".path
endfunction

" # Command Delview (and it's abbreviation 'delview')
command Delview call MyDeleteView()
" Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev delview <CR>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<CR>

com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
nnoremap <leader>x :FormatXML<CR>

set clipboard=unnamed

set errorbells

map q] :cn<CR>
map q[ :cp<CR>
map q{ :copen<CR>
map q} :cclose<CR>

map l] :ln<CR>
map l[ :lp<CR>
map l{ :lopen<CR>
map l} :lclose<CR>

" Disable obnoxious period repeat thing, so that I can use vim on an ipad
" without an ESC key with cmd+.
nnoremap . <nop>

function SetEditorViewOptions()
TagbarOpen
"Vexplore
endfunction

autocmd FileType cpp.doxygen call SetEditorViewOptions()
