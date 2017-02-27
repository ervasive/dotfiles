"
" Ale (linters)
" -----------------------------
Plug 'w0rp/ale'

let g:ale_sign_column_always = 1
let g:ale_sign_error = '󠀠⨉'
let g:ale_sign_warning = '󠀠⚠'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '✓ ok']
let g:ale_lint_on_save = 1

" Mappings
nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)
