" .vimrc
"
" By:   Tiago Faro Pedroso <tfpedroso [at] gmail [dot] com>
" Last Updated: 14.09.2015
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map leader key
let mapleader = "\<Space>"

" my personal help

fu! Helpme()
  echo " "
  echo " * buffers                                     * vundle"
  echo "   <Leader><Left>   - previous                   :PluginUpdate"
  echo "   <Leader><Right>  - next                       :PluginInstall"
  echo "   <Leader><Down>   - new"
  echo "   <Leader>l        - list"
  echo "   <Leader>ee       - delete/close"
  echo "   <Leader>w        - write all"
  echo "   <Leader>a        - write all & exit"
  echo "   <Leader>q        - quit without saving"
  echo " "
  echo " * sessions"
  echo "   <Leader>sl       - load"
  echo "   <Leader>ss       - save"
  echo "   <Leader>sd       - delete"
  echo "   <Leader>st       - call startity menu"
  echo " "
  echo " * others"
  echo "   <Leader>n        - toggle NerdTree"
  echo "   -                - line wrapping"
  echo "   ;h               - help"
  echo "   ;n               - numbering / unumbering lines"
  echo "   ;r               - reload .vimrc"
  echo "   ;t               - format file with perltidy"
  echo " "
endf

" ;h - Help
map <silent> ;h :exe Helpme()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'

" my plugins
Bundle 'joshdick/onedark.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'bling/vim-airline'
Bundle 'kien/ctrlp.vim'
"Bundle 'Shougo/unite.vim'
Bundle "myusuf3/numbers.vim"
Bundle "scrooloose/nerdtree"
Bundle "mhinz/vim-startify"
Bundle "gioele/vim-autoswap"
"Bundle "zenorocha/dracula-theme", {'rtp':'vim/'}
Bundle "joshdick/airline-onedark.vim"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"autocmd vimenter * NERDTree

syntax on
colorscheme onedark

set paste
set clipboard=unnamed

set directory=/tmp

"set tw=72

set background=dark
set nocompatible                " choose no compatibility with legacy vi
set visualbell
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=4 shiftwidth=4      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set list   listchars=tab:»·,trail:·

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" Automatically wrap at 72 characters and spell check git commit messages
autocmd FileType gitcommit setlocal textwidth=72
autocmd FileType gitcommit setlocal spell

"=====[ Enable smartwrapping ]==================================

" No smartwrapping in any of these files...
"let g:SW_IGNORE_FILES = '.vimrc,*.vim,*.pl,*.pm,**/bin/**'

set formatoptions-=cro

"set wrapmargin=2                            "Wrap 2 characters from the edge of the window
"set autoindent                              "Retain indentation on next line
set smartindent                             "Turn on autoindenting of blocks
inoremap # X<C-H>#|                         "And no magic outdent for comments
nnoremap <silent> >> :call ShiftLine()<CR>| "And no shift magic on comments

function! ShiftLine()
    set nosmartindent
    normal! >>
    set smartindent
endfunction

"=====[ Make Visual modes work better ]==================

" Visual Block mode is far more useful that Visual mode (so swap the commands)...
nnoremap v <C-V>
nnoremap <C-V> v

vnoremap v <C-V>
vnoremap <C-V> v

"Square up visual selections...
set virtualedit=block

" Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...
vmap <BS> x

" use CTRL+A to remove trailing spaces and convert tabs into spaces
nnoremap <silent> <C-A> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>

hi comment ctermfg=blue

" ;n - numbering / unumbering lines
map ;n :set invnumber<CR>

" ;r - Reload .vimrc (overrides previous options, but does not remove them)
map <silent> ;r :so $HOME/.vimrc<BAR>echo "Reloaded .vimrc"<CR>

" Format file with perltidy...
map ;t 1G!Gperltidy -b -w -ple -bbb -bbc -bbs -nolq -l=100 -noll -nola -isbc -nolc -otr -kis -ci=4 -se -sot -sct -nsbl -fs<CR>

" line wrapping
map <silent> - :set invwrap<BAR>echo "wrap is" (&wrap ? "on" : "off")<CR>

" some definitions
set backspace=2       " allow backspacing over everything in insert mode
set history=1000      " keep 1000 lines of command line history
set ruler         " show the cursor position all the time
set incsearch         " do incremental searching
set ic            " ignore case in search patterns
set scs           " smart search (override 'ic' when pattern has uppers)
set showcmd       " display incomplete commands
set nobackup          " do not keep a backup file, use versions instead
set laststatus=2      " always display the status line
set nosol         " cursor is kept in the same column (if possible)
set sw=4          " indentation now takes just 4 spaces at a time
set nrformats=        " only decimal numbers will be considered for increment

set fileformats=unix,mac,dos        "Handle Mac and DOS line-endings
                                    "but prefer Unix endings

set updatecount=10                  "Save buffer every 10 chars typed

" Insert shebang lines...
iab hbp #! /usr/bin/perl -w<CR>use strict;<CR>

" insert common Perl code structures...
iab udd use Data::Dumper 'Dumper';<CR>warn Dumper [];<ESC>hi
iab ubm use Benchmark qw( cmpthese );<CR><CR>cmpthese -10, {<CR>};<ESC>O
iab usc use Smart::Comments;<CR>###
iab pnl print "\n";<ESC>3hi
iab uts use Test::Simple 'no_plan';<CR><CR>
iab utm use Test::More 'no_plan';<CR><CR>
iab dbs $DB::single = 1;<ESC>

set statusline=%!MyStatusLine()

function! MyStatusLine()
    return "%F%m%r%h%w\ [format:%{&ff}]\ [type:%Y]\ [ascii:\%03.3b]\ [hex:\%02.2B]\ [pos:%04l,%04v]\ [%p%%]\ [len:%L]"
endfunction

"autocmd FileType c,cpp,java,php,perl autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Highlight .html files as Mason if they start with Mason tags
autocmd BufRead *.html
     \ if getline(1) =~ '^\(%\|<[%&].*>\)' |
     \     set filetype=perl |
     \ endif

"--B-U-F-F-E-R-S--------------------------------
" :ls
nnoremap <Leader>l :buffers<CR>:buffer<Space>

" quit all without saving 
nnoremap <Leader>q :qa!<CR>

" write all and exit
nnoremap <Leader>a :xa<CR>

" write all and keep working
nnoremap <Leader>w :wa<CR>

" unload buffer - close
nnoremap <Leader>ee :bd<CR>

"nnoremap <Leader><Left> :tabprevious<CR>
"nnoremap <Leader><Right> :tabnext<CR>
"nnoremap <Leader><Down> :tabe<Space>
nnoremap <Leader><Left> :bprevious<CR>
nnoremap <Leader><Right> :bnext<CR>
nnoremap <Leader><Down> :e<Space>

" call CtrlP
"nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>o :CtrlP<Space> .

set wildchar=<Tab> wildmenu wildmode=full

"autocmd VimEnter * tab all
"autocmd BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'

nnoremap <CR> G
nnoremap <BS> gg

tab all

"hi TabLineSel guifg=green guibg=darkgray gui=NONE ctermfg=green ctermbg=darkgray cterm=NONE
"hi TabLineFill guifg=darkgray guibg=NONE gui=NONE ctermfg=darkgray ctermbg=NONE cterm=underline
"hi TabLine guifg=darkgray guibg=NONE gui=NONE ctermfg=darkgray ctermbg=NONE cterm=underline

hi TabLineFill ctermfg=LightRed ctermbg=LightRed cterm=NONE
hi TabLine ctermfg=White ctermbg=LightRed cterm=NONE
hi TabLineSel ctermfg=White ctermbg=Black cterm=underline

"--B-U-F-F-E-R-S--------------------------------
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#fnamemod=':t'

"let g:airline_theme='murmur'
let g:airline_theme='onedark'
let g:airline_left_sep=''
let g:airline_right_sep=''

let g:airline#extensions#tabline#show_tab_nr = 0

let g:airline#extensions#tmuxline#enabled = 1

let g:onedark_termcolors=256
let g:onedark_terminal_italics=1

"always open NERD Tree on current directory
let g:NERDTreeChDirMode=2

map <Leader>n :NERDTreeToggle<CR>
" opens nerdtree on current file dir - no longer needed given the autocmd below
"map <Leader>nm :NERDTree %<CR>

" change current dir according to opened file
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" for save session
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds
"map <Leader>ss :mksession ~/my/vim-s/

" startify setup
let g:startify_session_dir='~/.vim/session'
map <Leader>sl :SLoad<CR>
map <Leader>ss :SSave<CR>
map <Leader>sd :SDelete<CR>
map <Leader>st :Startify<CR>

let g:startify_list_order = [
    \ ['   Sessions:'],
    \ 'sessions',
    \ ['   LRU:'],
    \ 'files',
    \ ['   LRU within this dir:'],
    \ 'dir',
    \ ['   Bookmarks:'],
    \ 'bookmarks',
    \ ]
