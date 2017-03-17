"
" Colorschemes helpers
" -----------------------------

"
" Hold aggregated colorschemes
" -----------------------------
let g:custom_colors = {}

"
" Register colorscheme and put it into `g:custom_colors`
" -----------------------------
function! colors#register(name, background, term, default)
  let l:default_defined = 0

  for color in values(g:custom_colors)
    if get(color, 'default')
      let l:default_defined = 1
    endif
  endfor

  let g:custom_colors[a:name] = {}
  let g:custom_colors[a:name].background = a:background
  let g:custom_colors[a:name].term_profile = a:term
  let g:custom_colors[a:name].default = l:default_defined ? 0 : a:default
endfunction

"
" Set active colorscheme based on set of rules, register cmds to switch them
" on the fly
" -----------------------------
function! colors#activate(color)
    let l:active = {}

    for [color, props] in items(g:custom_colors)
        " Determine active colorscheme
        if a:color == color || $NVIM_COLOR == color || props.default
            let l:active.color = color
            call extend(l:active, props)
        endif

        " Register commands
        let l:cmd_name = "SetColor" . toupper(strpart(color, 0, 1)) . strpart(color, 1)
        execute "command! " . l:cmd_name . " silent call colors#activate('" . color . "')"
    endfor

    execute "set background=" . l:active.background
    execute "colorscheme " . l:active.color

    " Can't change iTerm profile from Neovim interactively
    " https://github.com/neovim/neovim/issues/1496
     execute "silent !printf '\e]50;SetProfile=" . l:active.term_profile . "\x7'"

    " Re-run `ColorScheme` autocommand to update colorcheme
    doautocmd ColorScheme *

    " Update lightline
    if exists("g:lightline")
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    endif
endfunction

au VimEnter * call colors#activate('')

"
" Helper function to ease colorscheme modifications
" -----------------------------
function! colors#highlight(group, style)
    execute "highlight" a:group
        \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
        \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
        \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
        \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
        \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
        \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
        \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction
