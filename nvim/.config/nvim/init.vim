"
" Plugins - START
" -----------------------------
let $NR = fnamemodify( $MYVIMRC, ':p:h' )        " NeoVim root path
let $NP = $NR . '/plugins'                       " NeoVim plugins path

"
" Get Plug.vim if not installed
" -----------------------------
if empty(glob('$NR/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"
" Install plugins
" -----------------------------
call plug#begin()
    Plug 'ap/vim-css-color'                      " Highlight colors in css files
    Plug 'editorconfig/editorconfig-vim'         " Consistent coding styles
    Plug 'ervandew/supertab'                     " Perform all your vim insert mode completions with Tab
    Plug 'honza/vim-snippets'                    " Snippets for various programming languages
    Plug 'justinmk/vim-dirvish'                  " Directory viewer for Vim
    Plug 'majutsushi/tagbar'                     " Displays tags in a window
    Plug 'mattn/emmet-vim'                       " Expand HTML/CSS abbreviations
    Plug 'mattn/gist-vim'                        " Manage gists
    Plug 'mattn/webapi-vim'                      " An Interface to WEB APIs (dependency for gist-vim)
    Plug 'scrooloose/nerdcommenter'              " Comment/uncomment helper
    Plug 'sheerun/vim-polyglot'                  " Languages pack (syntaxes)
    Plug 'tmux-plugins/vim-tmux-focus-events'    " Make terminal vim and tmux work better together
    Plug 'tpope/vim-eunuch'                      " Vim sugar for the UNIX shell commands
    Plug 'tpope/vim-fugitive'                    " Git in VIM
    Plug 'tpope/vim-obsession'                   " Continuously updated session files
    Plug 'tpope/vim-surround'                    " Quoting/parenthesizing made simple
    Plug 'tpope/vim-unimpaired'                  " Pairs of handy bracket mappings
    Plug 'wakatime/vim-wakatime'                 " Automatic time tracking

    " PLugins with settings
    source $NP/ale.vim                           " Asynchronous Lint Engine
    source $NP/denite.vim                        " Fuzzy search for files, buffers etc.
    source $NP/deoplete.vim                      " Asynchronous completion framework
    source $NP/easymotion.vim                    " Search and navigate
    source $NP/gitgutter.vim                     " Git diff in the gutter (sign column)
    source $NP/gundo.vim                         " Visualize your Vim undo tree
    source $NP/lang-elm.vim                      " Plugin(s) for Elm support
    source $NP/lang-haskell.vim                  " Plugin(s) for Haskell support
    source $NP/lang-javascript.vim               " Plugin(s) for JavaScript support
    source $NP/lang-purescript.vim               " Plugin(s) for PureScript support
    source $NP/lightline.vim                     " Status line
    source $NP/neoformat.vim                     " Formatting code
    source $NP/nerdtree.vim                      " Tree files explorel
    source $NP/onedark.vim                       " Coloscheme
    source $NP/ultisnips.vim                     " Snippets manager
    source $NP/vim-bbye.vim                      " Delete buffers without closing windows
call plug#end()
"
" Plugins - END
" -----------------------------

"
" General
" -----------------------------
set hidden                                       " Preserve hidden buffers
set virtualedit=all                              " Allow free cursor positioning

"
" Visual
" -----------------------------
syntax on                                        " Enable syntax highlighting
set ruler                                        " Show line and column positions (status line overwrites this option)
set cursorline                                   " Highlight cursor line
set cc=80                                        " 80 characters delimiter
set nowrap                                       " Keep long lines
set number                                       " Display line numbers
set numberwidth=5                                " Number of columns for line numbers
set laststatus=2                                 " Always show status line
set cmdheight=1                                  " Consistent height for command line
set wildmenu                                     " Enable tab completions for command line
set wildmode=longest:full,full                   " Completions matches order
set list!                                        " Enable tabs/spaces/trailing etc. indicators
set listchars=tab:▸\ ,trail:·                    " Define characters for tabs/spaces/trailing etc. indicators
set scrolloff=8                                  " Keep 8 lines around cursor

" Enable 24-bit colors
if (has("termguicolors"))
    set termguicolors
endif

"
" Colorscheme
" -----------------------------
set background=dark                              " Adapt colors for selected colorscheme
colorscheme onedark                              " Colorscheme (installed through plugin 'onedark.vim')

"
" Indentation
" -----------------------------
set expandtab                                    " Use appropriate number of spaces to insert a <Tab>
set autoindent                                   " Indent using previous line lvl
set smartindent                                  " C-like langs smart indenting
set tabstop=2 shiftwidth=2                       " A tab is two spaces

"
" Search
" -----------------------------
set ignorecase                                   " Ignore case in search patterns
set smartcase                                    " Override 'ignorecase' if the search pattern contains upper case

" Un-highlight search matches
nnoremap <leader><leader> :noh<CR>

"
" Performance
" -----------------------------
set lazyredraw                                   " Do not redraw screen on macros execution

"
" Backups
" -----------------------------
set backup                                       " Create backup files
set writebackup                                  " Delete old backups
set backupdir=~/.config/nvim/backup//            " Where to save backup files
set directory=~/.config/nvim/backup//            " Where to save swap files

"
" Sessions
" -----------------------------
set undofile                                     " Maintain undo history between sessions
set undodir=~/.config/nvim/undodir//             " Where to save undo files

"
" Other
" -----------------------------
set updatetime=250                               " Make some plugins look more responsive (gitgutter etc.)

if has("mouse")
    set mouse=a                                  " Enable mouse support for all modes
    set mousehide                                " Hide mouse pointer on insert mode
endif

" Remember last position in closed file
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif
