"
" Solarized
" -----------------------------
Plug 'altercation/vim-colors-solarized'
call colors#register('solarized', 'light', 'Light', 0)

autocmd ColorScheme * call s:UpdateColorScheme()

function! s:UpdateColorScheme()
    if g:colors_name == 'solarized'
        let g:lightline.colorscheme = 'solarized'
    endif
endfunction
