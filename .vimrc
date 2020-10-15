" Vundle config
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim' "Vundle

Plugin 'rhysd/accelerated-jk' "Accelerated scrolling
Plugin 'raimondi/delimitmate' "Smart surround quote
Plugin 'yggdroot/indentline' "Smart indentation on yank-paste
Plugin 'tomtom/tlib_vim' "Utilities for other plugins
Plugin 'tpope/vim-commentary' "Comment/uncomment line using `gcc` for the current ligne `gc` for the selection
Plugin 'ap/vim-css-color' "Color hex
Plugin 'farmergreg/vim-lastplace' "Open file at the last position instead of top
Plugin 'sickill/vim-pasta' "Smart past
Plugin 'tpope/vim-surround' "Smart surround 
Plugin 'jszakmeister/vim-togglecursor' "Change cursor in INSERT mode
Plugin 'valloric/youcompleteme' "Smart autocompletion
Plugin 'vim-airline/vim-airline' "Nice status bar changing in Insert/Visual/Normal mode
Plugin 'vim-airline/vim-airline-themes'
Plugin 'derekwyatt/vim-scala' "Identify lexer error for Scala
Plugin 'w0rp/ale' "Syntax corrector
Plugin 'henrik/vim-indexed-search' "Tell number of match on a search
Plugin 'akhaku/vim-java-unused-imports' "Color unused imports for Java and Scala
Plugin 'tpope/vim-fugitive' "Git tools
Plugin 'hashivim/vim-terraform' "format tf
"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

autocmd BufWritePost * UnusedImports "Color unused import on save


" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

"VIM Configuration
set nocompatible        " Use Vim defaults (much better!)
set backspace=indent,eol,start      " Enable usual backspace comportment
set hidden      " Hide files while open other files
syntax enable       " Enable syntax color
set laststatus=2    " Always display the statusline in all windows
set nofixendofline
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds
set mouse=a
" -- Display
set title       " Update your terminal title
set number      " Display line number
set ruler       " Show cursor position
set wrap        " Auto-cut line which are longer than the screen
set scrolloff=3     " 3 lines display per scroll
" -- Search
set ignorecase      " Ignore case during search
set smartcase       " Active case if a search contain capital caracter
set incsearch       " Highlight search results while typing
set hlsearch        " Highlight search results
" -- Key-binding
let mapleader=","
set tabstop=8
set shiftwidth=2
set softtabstop=2
set expandtab
autocmd FileType php setlocal shiftwidth=4 softtabstop=4 expandtab
" -- Enable specific comportment for differents files types (syntax, indentation)
filetype on
filetype plugin on
filetype indent off
set autoindent
set smartindent
let g:CommandTMaxFiles=200000
" -- Aspect
set t_Co=256
set t_ut=
let g:spacegray_underline_search = 1
let g:spacegray_italicize_comments = 1
set background=dark    " Setting dark mode
" -- Define color theme 
colorscheme one
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

"" -- UseC-j/C-k to swipe lines bottom/top
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv")

" Remap 
nnoremap <C-n>   :tabnew<CR>

" -- Remap autocomplete popup selection
let g:ycm_key_list_select_completion = ['<S-j>']
let g:ycm_key_list_previous_completion = ['<S-k>']


set nofoldenable
"
" Autoreload file
set autoread
au CursorHold * checktime

set wildmenu
set wildmode=list:longest

" -- Define language for specific filetype
au BufRead,BufNewFile *.hql setfiletype sql 
au BufRead,BufNewFile *.sbt set filetype=scala
au BufRead,BufNewFile *.tfvars set filetype=tf
au BufRead,BufNewFile *.avsc set filetype=json
au BufRead,BufNewFile Jenkinsfile set filetype=groovy

autocmd FileType json syntax match Comment +\/\/.\+$+
"
" -- Define specific tab space for some languages
autocmd FileType java setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType xml setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType py setlocal shiftwidth=4 softtabstop=4 expandtab

" -- Set an horizontal baz at 120 chars
set colorcolumn=120
autocmd FileType python set colorcolumn=100
highlight ColorColumn ctermbg=lightgrey

let g:pymode_rope = 0
let g:pymode_rope_completion = 0

" -- Some java highlight omprovment
autocmd BufRead *.java set include=^#\s*import
autocmd BufRead *.java set includeexpr=substitute(v:fname,'\\.','/','g')

set path+=** " Improve file search for :find command

set statusline+=%#warningmsg#
set statusline+=%*
" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
" let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

command! MakeTags !ctags -R . "Define :MakeTags to create a tag file (so C-[ jump to a method definition)

let g:terraform_fmt_on_save=1
