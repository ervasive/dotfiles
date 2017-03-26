"
" Solarized
" -----------------------------
Plug 'altercation/vim-colors-solarized'
call colors#register('solarized', 'light', 'Light', 0)

autocmd ColorScheme * call s:UpdateColorScheme()

function! s:UpdateColorScheme()
    if g:colors_name == 'solarized'
        " Predefined colors
        let s:base_bg = { "gui": "#FDF6E3", "cterm": "17", "cterm16": "0" }
        let s:base_bg_shade_1 = { "gui": "#EEE8D5", "cterm": "17", "cterm16": "0" }

        " Override colors
        call colors#highlight( "VertSplit",  { "bg": s:base_bg_shade_1, "fg": s:base_bg_shade_1 })
        call colors#highlight( "NonText",    { "bg": s:base_bg, "fg": s:base_bg })
        call colors#highlight( "FoldColumn",  { "bg": s:base_bg, "fg": s:base_bg })

        " Lighline tweaks
        let g:lightline.colorscheme = 'solarized'
    endif
endfunction
