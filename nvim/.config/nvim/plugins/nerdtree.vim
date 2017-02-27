"
" Nerdtree
" -----------------------------
Plug 'scrooloose/nerdtree'

let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeWinSize=25
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Mappings
map <C-\> :NERDTreeToggle<CR>
