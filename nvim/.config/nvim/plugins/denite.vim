"
" Denite
" -----------------------------
Plug 'Shougo/denite.nvim'

autocmd User plugin call denite#custom#option('default', 'winheight', 10)

" Mappings
nnoremap <C-D>f :Denite file_rec<CR>
nnoremap <C-D>b :Denite -mode=normal buffer<CR>
nnoremap <C-D>l :Denite line<CR>

autocmd VimEnter * call denite#custom#map(
      \'normal',
      \'o',
      \'<denite:do_action:default>',
      \'noremap'
      \)
