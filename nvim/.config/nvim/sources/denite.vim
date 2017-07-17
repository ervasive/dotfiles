"
" Denite
" -----------------------------
Plug 'Shougo/denite.nvim'

autocmd User plugin call denite#custom#option('default', 'winheight', 10)

" Use `ag` for file_rec command.
autocmd VimEnter * call denite#custom#var('file_rec', 'command',
      \ ['ag',
      \  '--follow',
      \  '--nocolor',
      \  '--nogroup',
      \  '-g',
      \  ''
      \ ])

" Use `ag` command on grep source
autocmd VimEnter * call denite#custom#var('grep', 'command', ['ag'])
autocmd VimEnter * call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
autocmd VimEnter * call denite#custom#var('grep', 'recursive_opts', [])
autocmd VimEnter * call denite#custom#var('grep', 'pattern_opt', [])
autocmd VimEnter * call denite#custom#var('grep', 'separator', ['--'])
autocmd VimEnter * call denite#custom#var('grep', 'final_opts', [])

" Mappings
nnoremap <silent> <C-D>f :Denite file_rec<CR>
nnoremap <silent> <C-D>b :Denite buffer<CR>
nnoremap <silent> <C-D>l :Denite line<CR>
nnoremap <silent> <C-D>g :Denite grep<CR>

autocmd VimEnter * call denite#custom#map(
      \'insert',
      \'<C-o>',
      \'<denite:do_action:default>',
      \'noremap'
      \)

autocmd VimEnter * call denite#custom#map(
      \'insert',
      \'<C-d>',
      \'<denite:do_action:delete>',
      \'noremap'
      \)

autocmd VimEnter * call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)

autocmd VimEnter * call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)
