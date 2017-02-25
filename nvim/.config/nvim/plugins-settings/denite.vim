"
" Denite
" -----------------------------
Plug 'Shougo/denite.nvim'

autocmd User plugin call denite#custom#option('default', 'winheight', 10)
autocmd User plugin call denite#custom#map('normal', 'o', '<denite:do_action:default>', 'noremap')

" Mappings
nnoremap <C-D>f :Denite file_rec<CR>
nnoremap <C-D>b :Denite -mode=normal buffer<CR>
nnoremap <C-D>l :Denite line<CR>

