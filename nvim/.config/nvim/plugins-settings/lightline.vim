"
" Lightline (statusline)
" -----------------------------
Plug 'itchyny/lightline.vim'

let g:lightline = {
\     'colorscheme': 'onedark',
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
    return s:isSimpleBuffer() ? '' : lightline#mode()
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

    let l:buffer = bufnr('%')
    let [l:error_format, l:warning_format, l:no_errors] = g:ale_statusline_format
    let [l:error_count, l:warning_count] = ale#statusline#Count(l:buffer)

    return !l:error_count && !l:warning_count ? l:no_errors : ''
endfunction

function! LightlineAleWR()
    if !exists('g:ale_buffer_info') || s:isSimpleBuffer()
        return ''
    endif

    let l:buffer = bufnr('%')
    let [l:error_format, l:warning_format, l:no_errors] = g:ale_statusline_format
    let [l:error_count, l:warning_count] = ale#statusline#Count(l:buffer)

    return l:warning_count ? printf(l:warning_format, l:warning_count) : ''
endfunction

function! LightlineAleER()
    if !exists('g:ale_buffer_info') || s:isSimpleBuffer()
        return ''
    endif

    let l:buffer = bufnr('%')
    let [l:error_format, l:warning_format, l:no_errors] = g:ale_statusline_format
    let [l:error_count, l:warning_count] = ale#statusline#Count(l:buffer)

    return l:error_count ? printf(l:error_format, l:error_count) : ''
endfunction

augroup UpdateAleLightLine
    autocmd!
    autocmd User ALELint call lightline#update()
augroup END
