" Basic configuration for neovim, common between the application used
" as a git editor and as a general editor

let g:python3_host_prog='/usr/bin/python3'

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Color schemes:
Plug 'rakr/vim-one'
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'dylanaraps/wal.vim'

" Git-related
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'scrooloose/nerdtree'

" Providing autocompletion:
Plug 'Shougo/deoplete.nvim'

" Editing tools:
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/emmet-vim'
Plug 'ntpeters/vim-better-whitespace'

" Syntax highliting, language-specific commands and tools:
Plug 'dag/vim-fish'
Plug 'irrationalistic/vim-tasks'

call plug#end()


set nocompatible

" backups and other junky files
set backupdir=~/.vim/backup     " get backups outta here
set directory=~/.vim/swap       " get swapfiles outta here
set writebackup                 " temp backup during write
set undodir=~/.vim/undo         " persistent undo storage
set undofile                    " persistent undo on

set number
set showcmd
set laststatus=2
set lazyredraw
set ruler
set showmatch

" for formatting bulleted lists and numbered lists
set autoindent
set formatoptions+=n
set formatlistpat=^\\s*\\(\\d\\+[\\]:.)}\\t\ ]\\|-\\|\\*\\)\\s*

set mouse=a

" Show non-printing characters:
:set listchars=eol:¬,tab:»»,trail:~,extends:>,precedes:<,space:·
:set list


set background=dark

if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif

set termguicolors

" manually setting airline theme
" TODO: test alternatives:
" * base16_oceanicnext
" * tomorrow
" * ubaryd
let g:airline_theme='base16'

"let g:PaperColor_Theme_Options = {
"  \   'language': {
"  \     'python': {
"  \       'highlight_builtins' : 1
"  \     },
"  \     'cpp': {
"  \       'highlight_standard_library': 1
"  \     },
"  \     'c': {
"  \       'highlight_builtins' : 1
"  \     }
"  \   }
"  \ }

"let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = ' '
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = ' '

" Indentation and whitespace settings
autocmd FileType html,css,tasks,yaml setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType fish setlocal expandtab shiftwidth=4 softtabstop=4

autocmd BufWritePre * StripWhitespace


call deoplete#enable()
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

