"=============================================================================
" FILE: english.vim
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

let s:save_cpo = &cpo
set cpo&vim

function! unite#kinds#english#define() "{{{
  return s:kind
endfunction"}}}

let s:kind = {
      \ 'name' : 'english',
      \ 'default_action' : 'echo',
      \ 'action_table': {},
      \}

" Actions "{{{
" debug {{{
let s:kind.action_table.debug = {
      \ 'description' : 'debug',
      \ 'is_selectable' : 1,
      \ }
function! s:kind.action_table.debug.func(candidates)
  echomsg string(a:candidates)
endfunction
"}}}

" preview {{{
let s:kind.action_table.preview = {
      \ 'description' : 'preview word selected',
      \ 'is_selectable' : 1,
      \ }
function! s:kind.action_table.preview.func(candidates)
  for candidate in a:candidates
    echo candidate["word"]
    " FIXME 長い文字列が切れる。
    echo candidate["unite__abbr"]
  endfor
endfunction
"}}}

" preview {{{
let s:kind.action_table.marking = {
      \ 'description' : 'marking',
      \ 'is_selectable' : 1,
      \ }
function! s:kind.action_table.preview.func(candidates)
  for candidate in a:candidates
    let item_id = candidate.source__data["id"]
    ruby << EOF
    AlpacaEnglish.if_ruby_wrapper do
      item_id = VIM.evaluate("item_id")
      item = Item.find(item_id)
      if item
        item.mark.name = "1"
        item.save
      end
    end
EOF
  endfor
endfunction
"}}}

"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
