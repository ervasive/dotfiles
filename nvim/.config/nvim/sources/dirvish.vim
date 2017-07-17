"
" Dirvish (Directory viewer for Vim)
" -----------------------------
Plug 'justinmk/vim-dirvish'

let g:dirvish_mode = ':sort r /[^\/]$/'
let g:dirvish_relative_paths = 1

autocmd FileType dirvish call fugitive#detect(@%)
