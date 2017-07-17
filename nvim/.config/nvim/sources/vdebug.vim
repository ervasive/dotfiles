"
" Vdebug (DBGP debugger)
" -----------------------------
Plug 'joonty/vdebug'

autocmd VimEnter * call s:SetupVdebug()

function! s:SetupVdebug()

  " Mappings
  let g:vdebug_keymap['step_over'] = '<Down>'
  let g:vdebug_keymap['step_into'] = '<Right>'
  let g:vdebug_keymap['step_out'] = '<Left>'
endfunction
