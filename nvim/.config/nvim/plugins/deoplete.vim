"
" Deoplete (completion)
" -----------------------------
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 2
set completeopt-=preview

" Mappings
inoremap <expr><C-j> pumvisible() ? "\<C-n>"  : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>"  : "\<C-k>"
