"
" Dirvish (Directory viewer for Vim)
" -----------------------------
Plug 'justinmk/vim-dirvish'

autocmd FileType dirvish call fugitive#detect(@%)
