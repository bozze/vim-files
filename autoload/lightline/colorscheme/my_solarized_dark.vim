" =============================================================================
" Filename: autoload/lightline/colorscheme/my_solarized_dark.vim
" Version: 0.0
" Author: bozze
" License: MIT License
" Last Change: 2014/06/22 01:04:15.
" =============================================================================

let s:cuicolors = {
      \ 'black0': [ '8', '234', 'DarkGray' ],
      \ 'black1': [ '0', '235', 'Black' ],
      \ 'gray0': [ '10', '239', 'LightGreen' ],
      \ 'gray1': [ '11', '240', 'LightYellow' ],
      \ 'gray2':  [ '12', '244', 'LightBlue' ],
      \ 'gray3':  [ '14', '245', 'LightCyan' ],
      \ 'white0': [ '7', '187', 'LightGray' ],
      \ 'white1': [ '15', '230', 'White' ],
      \ 'yellow': [ '3', '136', 'DarkYellow' ],
      \ 'orange': [ '9', '166', 'LightRed' ],
      \ 'red': [ '1', '124', 'DarkRed' ],
      \ 'magenta': [ '5', '125', 'DarkMagenta' ],
      \ 'violet': [ '13', '61', 'LightMagenta' ],
      \ 'blue': [ '4', '33', 'DarkBlue' ],
      \ 'cyan': [ '6', '37', 'DarkCyan' ],
      \ 'green': [ '2', '64', 'DarkGreen' ],
      \ }

" The following condition only applies for the console and is the same
" condition vim-colors-solarized uses to determine which set of colors
" to use.
let s:solarized_termcolors = get(g:, 'solarized_termcolors', 256)
if s:solarized_termcolors != 256 && &t_Co >= 16
  let s:cuiindex = 0
elseif s:solarized_termcolors == 256
  let s:cuiindex = 1
else
  let s:cuiindex = 2
endif

let s:black0  = [ '#002b36', s:cuicolors.black0[s:cuiindex] ]
let s:black1  = [ '#073642', s:cuicolors.black1[s:cuiindex] ]
let s:gray0   = [ '#586e75', s:cuicolors.gray0[s:cuiindex] ]
let s:gray1   = [ '#657b83', s:cuicolors.gray1[s:cuiindex] ]
let s:gray2   = [ '#839496', s:cuicolors.gray2[s:cuiindex] ]
let s:gray3   = [ '#93a1a1', s:cuicolors.gray3[s:cuiindex] ]
let s:white0  = [ '#eee8d5', s:cuicolors.white0[s:cuiindex] ]
let s:white1  = [ '#fdf6e3', s:cuicolors.white1[s:cuiindex] ]
let s:yellow  = [ '#b58900', s:cuicolors.yellow[s:cuiindex] ]
let s:orange  = [ '#cb4b16', s:cuicolors.orange[s:cuiindex] ]
let s:red     = [ '#dc322f', s:cuicolors.red[s:cuiindex] ]
let s:magenta = [ '#d33682', s:cuicolors.magenta[s:cuiindex] ]
let s:violet  = [ '#6c71c4', s:cuicolors.violet[s:cuiindex] ]
let s:blue    = [ '#268bd2', s:cuicolors.blue[s:cuiindex] ]
let s:cyan    = [ '#2aa198', s:cuicolors.cyan[s:cuiindex] ]
let s:green   = [ '#859900', s:cuicolors.green[s:cuiindex] ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left	= [ [ s:black1, s:gray3 ], [ s:white0, s:gray0 ] ]
let s:p.normal.middle	= [ [ s:green, s:black1 ] ]
let s:p.normal.right	= [ [ s:black1, s:gray3 ], [ s:black0, s:gray0 ], [ s:gray1, s:black1 ]]
let s:p.inactive.left	= [ [ s:gray1, s:black1 ], [ s:black1, s:gray0 ] ]
let s:p.inactive.middle = [ [ s:gray2, s:black1 ] ]
let s:p.inactive.right	= [ [ s:gray2, s:black1 ] ]
let s:p.insert.left	= [ [ s:black1, s:white1 ], [ s:white1, s:blue ] ]
let s:p.insert.middle	= [ [ s:white0, s:blue ] ]
let s:p.insert.right = [ [ s:black1, s:white1 ], [ s:white0, s:blue ], [ s:black0, s:blue ] ]
let s:p.replace.left	= [ [ s:white0, s:red ], [ s:white0, s:gray1 ] ]
let s:p.replace.middle	= copy(s:p.normal.middle)
let s:p.replace.right	= copy(s:p.normal.right)
let s:p.visual.left	= [ [ s:white0, s:yellow ], [ s:white0, s:gray0 ] ]
let s:p.tabline.left	= [ [ s:white0, s:gray0 ] ]
let s:p.tabline.tabsel	= [ [ s:white0, s:black1 ] ]
let s:p.tabline.middle	= [ [ s:gray0, s:white0 ] ]
let s:p.tabline.right	= copy(s:p.normal.right)
let s:p.normal.error	= [ [ s:white0, s:red ] ]
let s:p.normal.warning	= [ [ s:black1, s:yellow ] ]

let g:lightline#colorscheme#my_solarized_dark#palette = lightline#colorscheme#flatten(s:p)
