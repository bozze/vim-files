" =============================================================================
" Filename: autoload/lightline/colorscheme/solarized.vim
" Version: 0.0
" Author: itchyny
" License: MIT License
" Last Change: 2013/08/27 10:24:28.
" =============================================================================
if &background ==# 'light'
  let g:lightline#colorscheme#my_solarized#palette = g:lightline#colorscheme#my_solarized_light#palette
else
  let g:lightline#colorscheme#my_solarized#palette = g:lightline#colorscheme#my_solarized_dark#palette
endif
