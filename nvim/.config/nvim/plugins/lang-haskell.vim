"
" Plugin(s) for Haskell support
" -----------------------------

" Omni completions
Plug 'eagletmt/neco-ghc'
let g:haskellmode_completion_ghc = 0
autocmd filetype haskell setlocal omnifunc=necoghc#omnifunc
