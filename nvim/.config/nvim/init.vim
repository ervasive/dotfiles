" -----------------------------
" Install Plug if not installed
" -----------------------------
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" -----------------------------
" Plugins - START
" -----------------------------
call plug#begin()
    Plug 'joshdick/onedark.vim'                                   " Colorscheme
    Plug 'itchyny/lightline.vim'                                  " Statusline
    Plug 'mattn/emmet-vim'                                        " Expand abbrs
    Plug 'moll/vim-bbye'                                          " Close buffer shortcut
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocmpletion
    Plug 'Shougo/denite.nvim'                                     " File/Buffer etc. finder
    Plug 'sheerun/vim-polyglot'                                   " Syntaxes
    Plug 'ervandew/supertab'                                      " Handle <tab> on completions
    Plug 'scrooloose/nerdcommenter'                               " (Un)comment
    "Plug 'easymotion/vim-easymotion'                              " Navigate with /
    Plug 'editorconfig/editorconfig-vim'                          " Editorconfig
    Plug 'tpope/vim-eunuch'                                       " Shell cmds helpers
    Plug 'lilydjwg/colorizer'                                     " Preview colors
    Plug 'w0rp/ale'                                               " Linters
    Plug 'sbdchd/neoformat'                                       " Formatters
    Plug 'majutsushi/tagbar'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'scrooloose/nerdtree'
    Plug 'sjl/gundo.vim'
    Plug 'tpope/vim-obsession'
	Plug 'tmux-plugins/vim-tmux-focus-events'
call plug#end()
" -----------------------------
" Plugins - END
" -----------------------------


"
" General
" -----------------------------
filetype plugin indent on
set encoding=utf-8
set hid
set virtualedit=all


"
" Visual
" -----------------------------
syntax on
set ruler
set cursorline
set cc=80
set nowrap
set number
set laststatus=2
set cmdheight=1
set wildmenu
set wildmode=longest:full,full
set list!
set listchars=tab:▸\ ,trail:·

if (has("nvim"))
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

if (has("termguicolors"))
    set termguicolors
endif


"
" Colorscheme
" -----------------------------
set background=dark
colorscheme onedark


"
" Indentation
" -----------------------------
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent


"
" Search
" -----------------------------
set ignorecase
set smartcase
set hlsearch
set incsearch


"
" Performance
" -----------------------------
set lazyredraw


"
" Backups
" -----------------------------
set backupdir=~/.nvim-backup
set directory=~/.nvim-backup
set backup
set writebackup
set noswapfile


"
" Other
" -----------------------------
set clipboard+=unnamedplus
set mouse=a
set iskeyword-=_


"
" Lightline (statusline)
" -----------------------------
let g:lightline = {
\     'colorscheme': 'onedark',
\     'active': {
\         'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
\         'right': [ [ 'lineinfo' ], [ 'percent'], [ 'ale' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
\     },
\     'component_function': {
\         'fugitive': 'LightlineFugitive',
\         'filename': 'LightlineFilename'
\     },
\     'component_expand': {
\         'ale': 'ALEGetStatusLine'
\     },
\     'component_type': {
\         'ale': 'error'
\     }
\ }

function! LightlineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
                \ fname == '__Tagbar__' ? g:lightline.fname :
                \ fname =~ '__Gundo\|NERD_tree' ? '' :
                \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
                \ &ft == 'unite' ? unite#get_status_string() :
                \ &ft == 'vimshell' ? vimshell#get_status_string() :
                \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
                \ ('' != fname ? fname : '[No Name]') .
                \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = '⥮ '
            let branch = fugitive#head()
            return branch !=# '' ? mark.branch : ''
        endif
    catch
    endtry
    return ''
endfunction


"
" Vim-bbye (close buffer on ZZ)
" -----------------------------
noremap ZZ :Bdelete<CR>


"
" Deoplete (completion)
" -----------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 2
set completeopt-=preview


"
" Easymotion
" -----------------------------
let g:EasyMotion_smartcase = 1
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)


"
" Ale (linters)
" -----------------------------
let g:ale_sign_column_always = 1
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '✓ ok']
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)

let g:ale_linters = {
\   'javascript': ['eslint'],
\}

"
" Neoformat
" -----------------------------
augroup fmt
    autocmd!
    autocmd BufWritePre * Neoformat
augroup END


"
" Nerdtree
" -----------------------------
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeHijackNetrw=1
map <C-\> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


"
" Denite
" -----------------------------
call denite#custom#option('default', 'winheight', 10)
call denite#custom#map('normal', 'o', '<denite:do_action:default>', 'noremap')
nnoremap <C-D>f :Denite file_rec<CR>
nnoremap <C-D>b :Denite -mode=normal buffer<CR>
nnoremap <C-D>l :Denite line<CR>


"
" Gundo
" -----------------------------
let g:gundo_width = 40
let g:gundo_right = 1
