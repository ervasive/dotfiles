"
" Neoformat
" -----------------------------
Plug 'sbdchd/neoformat'

augroup fmt
    autocmd!
    autocmd BufWritePre * Neoformat
augroup END
