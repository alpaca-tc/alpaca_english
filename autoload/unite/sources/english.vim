"=============================================================================
" FILE: english for unite.vim
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

let s:name = 'english'
let s:unite_source = {
      \ 'name': s:name,
      \ 'description' : '',
      \ 'hooks' : {},
      \ "kind": "common",
      \ 'default_action' : {},
      \}

function! s:unite_source.gather_candidates(args, context) "{{{
  " if result == ""
  "   return []
  " endif

  let result = {
        \ "word": "hoge",
        \ }

  return [result]
endfunction"}}}

function! unite#sources#english#define() "{{{
  return alpaca_english#is_active() ? s:unite_source : []
endfunction"}}}

function! s:unite_source.hooks.on_syntax(args, context)
endfunction


