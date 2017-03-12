"
" Onedark (colorscheme)
" -----------------------------
Plug 'joshdick/onedark.vim'

" Tweak stock colorscheme
if (has("autocmd") && !has("gui"))
    let s:black    = { "gui": "#282C34", "cterm": "17", "cterm16": "0" }
    let s:black_n1 = { "gui": "#252930", "cterm": "17", "cterm16": "0" }
    let s:black_p1 = { "gui": "#31363F", "cterm": "17", "cterm16": "0" }

    autocmd ColorScheme * call onedark#set_highlight("VertSplit", { "bg": s:black_n1, "fg": s:black_n1 })
    autocmd ColorScheme * call onedark#set_highlight("NonText", { "bg": s:black, "fg": s:black })

    " Status line tweaks
    autocmd ColorScheme * call onedark#set_highlight("StatusLine", { "bg": s:black_n1, "fg": s:black_n1 })
    autocmd ColorScheme * let s:palette = g:lightline#colorscheme#onedark#palette
    autocmd ColorScheme * let s:palette.normal.middle = [ [ s:black_n1.gui, s:black_n1.gui, 'NONE', 'NONE' ] ]
    autocmd ColorScheme * let s:palette.inactive.middle = s:palette.normal.middle
    autocmd ColorScheme * let s:palette.tabline.middle = s:palette.normal.middle
end
