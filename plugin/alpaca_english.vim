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

function! s:let(name, value) "{{{
  let value = type(a:value) == type("") ? "'".a:value. "'" : a:value
  execute "let " .a:name. " = exists('" .a:name. "') ? " . a:name ." : " . value
endfunction"}}}

let s:plugin_root_dir = expand("<sfile>:p:h:h")
call s:let('g:alpaca_english_enable', 0)
call s:let('g:alpaca_english_max_candidates', 20)
call s:let('g:alpaca_english_db_path',  s:plugin_root_dir . '/db/ejdict.sqlite3')
call s:let('g:alpaca_english_enable_duplicate_candidates', 0)
call s:let('g:alpaca_english_thesaurus_file', split(&thesaurus, ",")[0])

command! AlpacaEnglishDisable let b:alpaca_english_enable = 0
command! AlpacaEnglishEnable let b:alpaca_english_enable = 1
if has('mac')
  command! -range AlpacaEnglishSay :<line1>,<line2> call say#run()
endif

let s:save_cpo = &cpo
set cpo&vim

let &cpo = s:save_cpo
unlet s:save_cpo
" vim:foldmethod=marker
