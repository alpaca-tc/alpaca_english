let s:save_cpo = &cpo
set cpo&vim

let s:name =  'english'
let s:source = {
      \ 'name' : s:name,
      \ 'kind' : 'plugin'
      \ }

function! s:source.initialize() "{{{
endfunction "}}}

function! s:source.finalize() "{{{
endfunction "}}}

function! s:to_canditates(dict) "{{{
  let res = []
  for record in a:dict
    let can = {
          \ "word" : record[1],
          \ "abbr" : record[1]. " ". record[2],
          \ "menu" : "[EN]"
          \ }
    call add(res, can)
  endfor

  return res
endfunction"}}}

function! s:source.get_keyword_list(cur_keyword_str) "{{{
  if (exists('b:alpaca_english_enable') ) ?
        \ !b:alpaca_english_enable :
        \ !(neocomplcache#is_text_mode() || neocomplcache#within_comment())
        \ || a:cur_keyword_str !~ '^[[:alpha:]]\+$'
    return []
  endif

  let result = alpaca_english#get_record(a:cur_keyword_str)

  return s:to_canditates(result)
endfunction"}}}

function! neocomplcache#sources#english#define() "{{{
  return alpaca_english#is_active() ? s:source : {}
endfunction"}}}

" vim: foldmethod=marker
