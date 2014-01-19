"=============================================================================
" FILE: thesaurus.vim
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
      \ 'name': 'english_thesaurus',
      \ 'description' : 'show thesaurus',
      \ }

function! s:to_canditates(result) "{{{
  let canditates = []
  for candidate in a:result
    let thesaurus = join(candidate['thesaurus'], ', ')
    let word = join([candidate['english'], candidate['transrate']], "\n")
    let candidate_converted = {
          \ 'word' : word,
          \ 'is_multiline' : 1,
          \ '__unite_english' : candidate['english'],
          \ '__unite_transrate': candidate['transrate'],
          \ '__unite_thesaurus': candidate['thesaurus'],
          \ }
    call add(canditates, candidate_converted)
  endfor

  return canditates
endfunction"}}}

function! s:unite_source.gather_candidates(args, context) "{{{
  call alpaca_english#initialize()
  let input = unite#english_util#get_input(a:context)

  ruby << EOF
  require 'mechanize'
  agent = Mechanize.new
  word = RubyVIM.get('input')
  page = agent.get("http://ejje.weblio.jp/english-thesaurus/content/#{word}")
  list = page.search("div[@class='kiji']/table[@class='wdntT']//tr")

  candidates = []
  list.each do |element|
    result = {}
    result['words'] = element.search("p[@class='wdntCL']").text
    result['transrate'] = element.search("p[@class='wdntTCLJ']").text
    result['thesaurus'] = result['words'].split(", ")
    result['english'] = element.search("p[@class='wdntTCLE']").text

    candidates << result unless result['words'].empty?
  end

  RubyVIM.let('result', candidates)
EOF

  if input =~ '^\s*$' || empty(result)
    return [{ 'word' : 'error occurd', 'is_dummy' : 1 }]
  else
    return s:to_canditates(result)
  endif
endfunction"}}}

function! unite#sources#english_thesaurus#define() "{{{
  return alpaca_english#is_active() ? s:unite_source : {}
endfunction"}}}
