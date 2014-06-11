"
" .vimrc - vim configuration file
"
"---( Pathogen )------------------------------------------------------------{{{
runtime bundle/vim-pathogen/autoload/pathogen.vim
"let g:pathogen_disabled = []
"call add(g:pathogen_disabled, 'plugin-name')
call pathogen#infect()
"---}}}

"---( Config vars )---------------------------------------------------------{{{
set nocompatible
set backspace=indent,eol,start
set cindent
set smartindent
set autoindent
filetype indent on
set nofoldenable
set foldmethod=marker
set history=50
set laststatus=2
set modeline
set modelines=5
set noincsearch
set ruler
set showcmd
set viminfo=%20,'20,/50,:50,@50,f1,s100,n~/.vim/viminfo
set sts=2
set sw=2
"---}}}

"---( Special folders )-----------------------------------------------------{{{
" Swap files
let mydirectory = $HOME . '/.vim/tmp/'
if !isdirectory(mydirectory)
  call mkdir(mydirectory, '', 0700)
endif
let &directory = mydirectory . ',' . &directory

" Undo 
set undofile
let myundodir = $HOME . '/.vim/undo/'
if !isdirectory(myundodir)
  call mkdir(myundodir, '', 0700)
endif
let &undodir = myundodir . ',' . &undodir

" Backups
set nobackup
let mybackupdir = $HOME . '/.vim/backup/'
if !isdirectory(mybackupdir)
  call mkdir(mybackupdir, '', 0700)
endif
let &backupdir = mybackupdir . ',' . &backupdir
"---}}}

"---( Appearance )----------------------------------------------------------{{{
"
" Theme, colors & syntax hilighting
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set incsearch
  set background=dark
  " unset 'Clearing with background color'
  " see: http://sunaku.github.io/vim-256color-bce.html
  set t_ut=
  let g:solarized_termcolors=16
  silent! colorscheme solarized
endif

" Cursor shape (Normal = block / Insert = vertical bar)
if &term =~ "^screen"
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Use the same symbols as TextMate
if &encoding ==? "utf-8"
	set listchars=tab:▸–,eol:¶,trail:❖,nbsp:¬,extends:»,precedes:«
else
	set listchars=tab:>-,eol:$,trail:#,nbsp:#,extends:>,precedes:<
endif

" Mouse °o°
if has('mouse')
  set mouse=in		" mouse active modes : a,n,v,i...
  set ttymouse=xterm2
endif
"---}}}

"---( Keyboard mappings )---------------------------------------------------{{{
let mapleader = " "
nnoremap + :noh<CR>
nnoremap <Leader>b :let &background = ( &background == "dark"? "light" : "dark" )\|hi! link SignColumn LineNr<CR>
nnoremap <Leader>n :set nu!<CR>
nnoremap <Leader>w :set wrap!<CR>
nnoremap <leader>l :set list!<CR>
nnoremap <leader><left> :bp<CR>
nnoremap <leader><right> :bn<CR>
nnoremap <leader><TAB> :bl<CR>
nnoremap <leader>q :bp <BAR> bd #<CR>

"---}}}

"---( Plugins )-------------------------------------------------------------{{{

"""
" NERDTree configuration
"
map <C-f> :NERDTreeToggle<CR>
map <leader>f :NERDTreeToggle<CR>
" open NERDTree automatically when vim starts up if no files were specified
"autocmd vimenter * if !argc() | NERDTree | endif
" close vim when no files are opened
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"""
" Airline status/tabline config
"
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '⮀'
let g:airline#extensions#tabline#left_alt_sep = '⮁'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols = {'linenr': '⭡', 'paste': 'PASTE', 'readonly': '⭤', 'modified': '+', 'space': ' ', 'whitespace': '⎵', 'branch': '⭠'}

"---}}}
