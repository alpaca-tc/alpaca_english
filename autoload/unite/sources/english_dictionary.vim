"=============================================================================
" FILE: english.vim
" AUTHOR: Ishii Hiroyuki <alprhcp666@gmail.com>
" Last Modified: Jan 19 2014
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
let s:unite_source = {
      \ 'name': 'english_dictionary',
      \ 'description' : 'english <-> japanese',
      \ 'hooks' : {},
      \ 'is_volatile': 1,
      \ 'max_candidates' : 50,
      \ 'matchers' : 'matcher_english',
      \}

let s:filters = {
  \ 'name' : 'matcher_english',
  \ }
function! s:filters.filter(candidates, context) "{{{
  return a:candidates
endfunction "}}}
call unite#define_filter(s:filters)


function! s:to_canditates(dict) "{{{
  let result = []
  for record in a:dict
    let candidate = {
          \ 'word' : record[1] . ' ' . record[2],
          \ 'abbr' : record[1] . ' ' . record[2],
          \ '__unite_english' : record[1],
          \ '__unite_transrate' : record[2],
          \ }
    call add(result, candidate)
  endfor

  return result
endfunction"}}}

function! s:get_splash() "{{{
  return [
        \ { 'word' : "Hi, I'm alpaca_english! ・T・", 'is_dummpy': 1 },
        \ { 'word' : "Let's input any word.", 'is_dummpy': 1 },
        \ { 'word' : '', 'is_dummpy': 1 },
        \ { 'word' : ' word   => and filter', 'is_dummpy': 1 },
        \ { 'word' : ' |word  => or filter', 'is_dummpy': 1, 'is_multiline': 1 },
        \ { 'word' : ' %word  => fuzzy filter', 'is_dummpy': 1, 'is_multiline': 1 },
        \ { 'word' : ' 日本語 => 英和辞書', 'is_dummpy': 1, 'is_multiline': 1 },
        \ ]
endfunction "}}}

function! s:unite_source.gather_candidates(args, context) "{{{
  let input = a:context.input

  if input =~ '^\s*$'
    return s:get_splash()
  else
    let result = alpaca_english#sqlite#search_with_complex_conditions(a:args, a:context)
    return empty(result) ? result : s:to_canditates(result)
  endif
endfunction "}}}

function! unite#sources#english_dictionary#define() "{{{
  return alpaca_english#is_active() ? s:unite_source : {}
endfunction"}}}
