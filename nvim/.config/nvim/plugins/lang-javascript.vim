"
" Plugin(s) for JavaScript support
" -----------------------------

" Omni completions
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'
let g:tern#filetypes = [
      \ 'jsx',
      \ 'javascript.jsx',
      \ 'vue'
      \ ]
