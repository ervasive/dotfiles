" -----------------------------
" Plugins - START
" -----------------------------
let $SP = fnamemodify( $MYVIMRC, ':p:h' ) " Settings path
let $PS = $SP . '/plugins-settings'       " Plugins settings path

"
" Get Plug.vim if not installed
" -----------------------------
if empty(glob('$SP/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"
" Install plugins
" -----------------------------
call plug#begin()
    Plug 'airblade/vim-gitgutter'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'ervandew/supertab'
    Plug 'joshdick/onedark.vim'
    Plug 'lilydjwg/colorizer'
    Plug 'majutsushi/tagbar'
    Plug 'mattn/emmet-vim'
    Plug 'scrooloose/nerdcommenter'
    Plug 'sheerun/vim-polyglot'
    Plug 'tmux-plugins/vim-tmux-focus-events'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-obsession'

    " PLugins with settings
    source $PS/ale.vim
    source $PS/denite.vim
    source $PS/deoplete.vim
    source $PS/easymotion.vim
    source $PS/gundo.vim
    source $PS/lightline.vim
    source $PS/neoformat.vim
    source $PS/nerdtree.vim
    source $PS/vim-bbye.vim
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
