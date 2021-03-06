"
" Lightline (statusline)
" -----------------------------
Plug 'itchyny/lightline.vim'

let g:lightline = {
\     'active': {
\         'left': [
\             [ 'mode', 'paste' ],
\             [ 'fugitive', 'filename' ],
\         ],
\         'right': [
\             [ 'lineinfo' ],
\             [ 'percent' ],
\             [ 'aleOK', 'aleWR', 'aleER' ],
\             [ 'fileformat', 'fileencoding', 'filetype' ],
\         ],
\     },
\     'component_function': {
\         'filename': 'LightlineFilename',
\         'fileformat': 'LightlineFileformat',
\         'fileencoding': 'LightlineFileencoding',
\         'mode': 'LightlineMode',
\         'fugitive': 'LightlineFugitive',
\     },
\     'component_expand': {
\         'aleOK': 'LightlineAleOK',
\         'aleWR': 'LightlineAleWR',
\         'aleER': 'LightlineAleER',
\     },
\     'component_type': {
\         'aleOK': '',
\         'aleWR': 'warning',
\         'aleER': 'error',
\     },
\ }

" Check if buffer is 'simple'
" ------------------------------
function! s:isSimpleBuffer()
    return expand('%:t') !~? 'Tagbar\|Gundo\|NERD' ? 0 : 1
endfunction

" Modified buffer
" ------------------------------
function! LightlineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

" Read-only buffer
" ------------------------------
function! LightlineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

" Custom mode (hide for 'simplified' buffers)
" ------------------------------
function! LightlineMode()
    return s:isSimpleBuffer() ? '' : strpart(lightline#mode(), 0, 1)
endfunction

" Custom filename
" ------------------------------
function! LightlineFilename()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? g:lightline.fname :
         \ s:isSimpleBuffer() ? '' :
         \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
         \ ('' != fname ? fname : '[No Name]') .
         \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

" Custom fileformat
" ------------------------------
function! LightlineFileformat()
    return s:isSimpleBuffer() ? '' : &fileformat
endfunction

" Custom fileencoding
" ------------------------------
function! LightlineFileencoding()
    return s:isSimpleBuffer() ? '' : &fileencoding
endfunction

" Fugitive
" ------------------------------
function! LightlineFugitive()
    try
        if !s:isSimpleBuffer() && exists('*fugitive#head')
            let mark = '⥮ '
            let branch = fugitive#head()
            return branch !=# '' ? mark.branch : ''
        endif
    catch
    endtry
    return ''
endfunction

" Ale (linters) validation
" ------------------------------
function! LightlineAleOK()
    if !exists('g:ale_buffer_info') || s:isSimpleBuffer()
        return ''
    endif

    let l:counts = ale#statusline#Count(bufnr(''))
    return l:counts.total == 0 ? 'OK' : ''
endfunction

function! LightlineAleWR()
    if !exists('g:ale_buffer_info') || s:isSimpleBuffer()
        return ''
    endif

    let l:counts = ale#statusline#Count(bufnr(''))
    return l:counts.style_error ? l:counts.style_error : ''
endfunction

function! LightlineAleER()
    if !exists('g:ale_buffer_info') || s:isSimpleBuffer()
        return ''
    endif

    let l:counts = ale#statusline#Count(bufnr(''))
    return l:counts.error ? l:counts.error : ''
endfunction

augroup UpdateAleLightLine
    autocmd!
    autocmd User ALELint call lightline#update()
augroup END
