"=============================================================================
" FILE: alpaca_english.vim
" AUTHOR: Ishii Hiroyuki <alprhcp666@gmail.com>
" Last Modified: 2013-04-21
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================
if exists('g:loaded_alpaca_english')
  finish
endif
let g:loaded_alpaca_english = 1

" initialize"{{{
" Function for initializing "{{{
function! s:initialize()
  let g:alpaca_english_enable = get(g:, 'alpaca_english_enable', 1)
  let g:alpaca_english_max_candidates  = get(g:, 'alpaca_english_max_candidates', 20)
  " とりあえずRubyだけ対応
  if exists('g:neobundle#default_options')
    let dir = neobundle#get_neobundle_dir()
    let g:alpaca_english_db_path = get(g:, 'alpaca_english_db_path',
          \ dir . '/alpaca_english/db/ejdict.sqlite3')
    let g:alpaca_english_root_dir = get(g:, 'alpaca_english_root_dir',
          \ dir . '/alpaca_english')

  endif
endfunction "}}}

if get(g:, 'alpaca_english_enable', 0) "{{{
  call s:initialize()
else
  let g:alpaca_english_enable = 0
endif "}}}
"}}}

" define commands"{{{
" XXX 今は動かないから。消す
command! AlpacaEnglishDisable let b:alpaca_english_enable = 0
"}}}

let s:save_cpo = &cpo
set cpo&vim

let &cpo = s:save_cpo
unlet s:save_cpo
" vim:foldmethod=marker
