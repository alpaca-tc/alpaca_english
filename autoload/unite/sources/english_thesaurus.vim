"=============================================================================
" FILE: thesaurus.vim
" AUTHOR: Ishii Hiroyuki <alprhcp666@gmail.com>
" Last Modified: 2013-05-12
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
      \ 'name': 'english_thesaurus',
      \ 'description' : 'show thesaurus',
      \ }

function! s:to_canditates(result) "{{{
  let canditates = []
  for can in a:result
    let candidate = {
          \ "word" : can["english"] . "\n" . can["transrate"] . "\n" . join(can["thesaurus"], ", "),
          \ "is_multiline" : 1,
          \ "__unite_english" : can["english"],
          \ "__unite_transrate": can["transrate"],
          \ "__unite_thesaurus": can["thesaurus"],
          \ }
    call add(canditates, candidate)
  endfor

  return canditates
endfunction"}}}

function! s:unite_source.gather_candidates(args, context) "{{{
  call alpaca_english#initialize()
  let input = unite#english_util#get_input(a:context)

  " TODO リファクタリング
  ruby << EOF
  require 'mechanize'
  agent = Mechanize.new
  word = VIM.get("input")
  page = agent.get("http://ejje.weblio.jp/english-thesaurus/content/#{word}")
  list = page.search("div[@class='kiji']/table[@class='wdntT']//tr")

  complete = []
  list.each do |element|
    res = {}
    res["words"] = element.search("p[@class='wdntCL']").text
    res["transrate"] = element.search("p[@class='wdntTCLJ']").text
    res["thesaurus"] = res["words"].split(", ")
    res["english"] = element.search("p[@class='wdntTCLE']").text

    complete << res unless res["words"].empty?
  end

  VIM.let("result", complete)
EOF

  if input =~ '^\s*$' || empty(result) 
    return [{"word" : "error occurd", "is_dummy" : 1}]
  else
    return s:to_canditates(result)
  endif
endfunction"}}}

function! unite#sources#english_thesaurus#define() "{{{
  return alpaca_english#is_active() ? s:unite_source : {}
endfunction"}}}
"}}}
