"
" Directory listing settings
set wildignore+=*.so,*.swp,*.o,*/docs/html/*,*.orig,*.pyc,
set wildignore+=.dir*,.deps/*,.hg/*


map <C-n> :NERDTreeToggle<CR>
autocmd vimenter *.(c|h)pp NERDTree

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeWinSize = 20
