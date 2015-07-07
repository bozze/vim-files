"
" .vimrc - vim configuration file
"
"---( Pathogen )------------------------------------------------------------{{{
runtime bundle/vim-pathogen/autoload/pathogen.vim
let g:pathogen_disabled = ['vim-airline']
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
set expandtab
set copyindent
set preserveindent
set softtabstop=2
set shiftwidth=2
set tabstop=2
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
  " Mode displayed by Lightline statusbar
  set noshowmode
  set cursorline
  " unset 'Clearing with background color'
  " see: http://sunaku.github.io/vim-256color-bce.html
  set t_ut=
  let g:solarized_termcolors=16
  silent! colorscheme solarized
  " set Sign column color to Line numbers column color
  hi! link SignColumn LineNr
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

" Highlight trailing spaces (https://github.com/bronson/vim-trailing-whitespace)
highlight ExtraWhitespace ctermbg=darkblue guibg=#382424
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkblue guibg=#382424
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" The above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" Toggle background color and update lightline statusbar
function! ToggleBackground() " {{{
  let &background = ( &background == "dark"? "light" : "dark" )
  let g:lightline.colorscheme="my_solarized_{&background}"
  call lightline#init() | call lightline#update()
  hi! link SignColumn LineNr
endfunction " }}}
"---}}}

"---( Keyboard mappings )---------------------------------------------------{{{
let mapleader = " "
nnoremap + :noh<CR>
nnoremap <Leader>b :call ToggleBackground()<CR>
nnoremap <Leader>n :set nu!<CR>
nnoremap <Leader>w :set wrap!<CR>
nnoremap <leader>l :set list!<CR>
nnoremap <leader><left> :bp<CR>
nnoremap <leader><right> :bn<CR>
nnoremap <leader><TAB> :bl<CR>
nnoremap <leader>q :bp <BAR> bd #<CR>
nnoremap <Leader>c :set cursorline!<CR>
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
" Lightline status/tabline config
"
let g:lightline = {
  \ 'colorscheme': 'my_solarized',
  \ 'component': {
    \ 'percent'    : '%3p%%'
  \ },
  \ 'active': {
    \ 'left': [ [ 'mode', 'paste' ],
      \ [ 'fugitive', 'filename' ] ],
    \ 'right': [
      \ [ 'percent' ],
      \ [ 'lineinfo' ],
      \ [ 'filetype', 'fileencoding' ],
      \ [ 'whitespace' ] ],
  \ },
  \ 'inactive': {
    \ 'left': [ ['mode', 'paste'],
      \ [ 'fugitive', 'filename' ] ],
  \ 'right': []
  \ },
  \ 'component_function': {
    \ 'readonly'    : 'MyReadonly',
    \ 'modified'    : 'MyModified',
    \ 'fugitive'    : 'MyFugitive',
    \ 'filename'    : 'MyFilename',
    \ 'fileencoding': 'MyFileencoding',
    \ 'filetype'    : 'MyFiletype',
    \ 'mode'	      : 'MyMode',
    \ 'lineinfo'    : 'MyLineinfo',
    \ 'whitespace'  : 'MyWhitespace',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
\ }
function! MyReadonly() " {{{
  return &readonly ? '' : ''
endfunction " }}}

function! MyModified() " {{{
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction " }}}

function! MyFugitive() " {{{
  if winwidth(0) > 6 && expand('%:t') !~? 'Tagbar\|Gundo\|NERD'
    \ && &ft !~? 'vimfiler' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction " }}}

function! MyFilename() " {{{
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
    \ fname == '__Tagbar__' ? g:lightline.fname :
    \ fname =~ '__Gundo\|NERD_tree' ? '' :
    \ &ft == 'help' ? '' :
    \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
    \ &ft == 'unite' ? unite#get_status_string() :
    \ &ft == 'vimshell' ? vimshell#get_status_string() :
    \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
    \ ('' != fname ? fname : '[No Name]') .
    \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction " }}}

function! MyFileencoding() " {{{
  let fileenc = (strlen(&fenc) ? toupper(&fenc) : &enc) . ('unix' == &fileformat ? '' : '(' . &fileformat . ')')
  return winwidth(0) >= strlen(MyMode()) + strlen(MyFugitive()) + strlen(MyFilename()) + 24 + 24 ? fileenc : ''
endfunction " }}}

function! MyFiletype() " {{{
  let ftype = (strlen(&filetype) ? &filetype : 'no ft')
  return winwidth(0) >= strlen(MyMode()) + strlen(MyFugitive()) + strlen(MyFilename()) + 24 + 32 ? ftype : ''
endfunction " }}}

function! MyMode() " {{{
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
    \ fname == 'ControlP' ? 'CtrlP' :
    \ fname == '__Gundo__' ? 'Gundo' :
    \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
    \ fname =~ 'NERD_tree' ? 'NERD Tree' :
    \ &ft == 'help' ? 'HELP' :
    \ &ft == 'unite' ? 'Unite' :
    \ &ft == 'vimfiler' ? 'VimFiler' :
    \ &ft == 'vimshell' ? 'VimShell' : lightline#mode()
    "\ winwidth(0) > 55 ? lightline#mode() : ''
endfunction " }}}

function! MyLineinfo() " {{{
  let l:cl = line(".")
  let l:ll = line("$")
  let l:cc = col(".")
  let l:fm = printf("↓ %%0%dd → %%03d", strlen(l:ll))
  let l:li = printf(l:fm, l:cl, l:cc)
  return expand('%:t') !~? 'Tagbar\|Gundo\|NERD'
        \ && winwidth(0) >= strlen(MyMode()) + strlen(MyFugitive()) + strlen(MyFilename()) + 24 + 16 ? l:li : ''
endfunction " }}}

function! MyWhitespace() " {{{
  let [lnum,cnum] = searchpos('\s\+$', 'nw')
  let trailing = lnum != 0 && cnum != 0 ? '⎵ :'.lnum : ''
  let tabs = search('^\t', 'nw') != 0
  let spaces = search('^ ', 'nw') != 0
  return (tabs && spaces ? '[mixed]' : '') . trailing
endfunction " }}}

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked) " {{{
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction " }}}

function! CtrlPStatusFunc_2(str) " {{{
  return lightline#statusline(0)
endfunction " }}}
"---}}}
