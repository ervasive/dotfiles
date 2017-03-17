"
" Onedark (colorscheme)
" -----------------------------
Plug 'joshdick/onedark.vim'
call colors#register('onedark', 'dark', 'Dark', 1)

autocmd ColorScheme * call s:UpdateColorScheme()

function! s:UpdateColorScheme()
    if g:colors_name == 'onedark'
        " Predefined colors
        let s:black    = { "gui": "#282C34", "cterm": "17", "cterm16": "0" }
        let s:black_n1 = { "gui": "#252930", "cterm": "17", "cterm16": "0" }
        let s:black_p1 = { "gui": "#31363F", "cterm": "17", "cterm16": "0" }

        " Override colors
        call colors#highlight( "VertSplit",  { "bg": s:black_n1, "fg": s:black_n1 })
        call colors#highlight( "NonText",    { "bg": s:black,    "fg": s:black })
        call colors#highlight( "StatusLine", { "bg": s:black_n1 })

        " Lighline tweaks
        let g:lightline.colorscheme = 'onedark'

        let s:palette = g:lightline#colorscheme#onedark#palette
        let s:palette.normal.middle = [ [ s:black_n1.gui, s:black_n1.gui, 'NONE', 'NONE' ] ]
        let s:palette.inactive.middle = s:palette.normal.middle
        let s:palette.tabline.middle = s:palette.normal.middle
    endif
endfunction
