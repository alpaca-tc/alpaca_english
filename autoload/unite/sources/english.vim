"=============================================================================
" FILE: english.vim
" AUTHOR: Ishii Hiroyuki <alprhcp666@gmail.com>
" Last Modified: 2013-04-23
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
      \ 'name': 'english/dictionary',
      \ 'description' : 'english <-> japanese',
      \ 'hooks' : {},
      \ 'is_volatile': 1,
      \ 'max_candidates' : 50,
      \ 'matchers' : 'matcher_english',
      \}

" define filter"{{{
" TODO filtersに移動
let s:filters = {
  \ "name" : "matcher_english",
  \ }

function! s:filters.filter(candidates, context)
  return a:candidates
endfunction
call unite#define_filter(s:filters)
"}}}

function! s:to_canditates(dict) "{{{
  let res = []
  for record in a:dict
    let can = {
          \ "word" : record[1]. " " . record[2],
          \ "abbr" : record[1]. " " . record[2],
          \ "__sql_value_word" : record[1],
          \ "__sql_value_mean" : record[2],
          \ }
    call add(res, can)
  endfor

  return res
endfunction"}}}

function! s:get_dummy_candidates() "{{{
  return [
        \ {"word": "Hi, I'm alpaca_english! ・T・", "is_dummpy": 1 },
        \ {"word": "Let's input any word.", "is_dummpy": 1 },
        \ {"word": "", "is_dummpy": 1 },
        \ {"word": " word   => and filter", "is_dummpy": 1 },
        \ {"word": " |word  => or filter", "is_dummpy": 1, "is_multiline": 1 },
        \ {"word": " %word  => fuzzy filter", "is_dummpy": 1, "is_multiline": 1 },
        \ {"word": " 日本語 => 英和辞書", "is_dummpy": 1, "is_multiline": 1 },
        \ ]
endfunction"}}}

" define source"{{{
function! s:unite_source.gather_candidates(args, context) "{{{
  let input = a:context["input"]

  if input =~ '^\s*$'
    return s:get_dummy_candidates()
  else
    let res = alpaca_english#sqlite#search_with_complex_conditions(a:args, a:context)
    return empty(res) ? res : s:to_canditates(res)
  endif
endfunction"}}}

function! s:unite_source.hooks.on_syntax(args, context)
endfunction

function! unite#sources#english#define()
  return alpaca_english#is_active() ? s:unite_source : {}
endfunction
"}}}
