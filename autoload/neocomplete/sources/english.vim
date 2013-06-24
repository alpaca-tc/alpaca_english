let s:save_cpo = &cpo
set cpo&vim

let s:source = {
      \ "name" : "english",
      \ "kind" : "plugin",
      \ "mark" : "[en]",
      \ "max_candidates" : 15,
      \ "min_pattern_length" : 3,
      \ "is_volatile": 1,
      \ }

function! s:to_canditates(dict) "{{{
  let res = []
  for record in a:dict
    let can = {
          \ "word" : record[1],
          \ "abbr" : record[1]. " ". record[2],
          \ "menu" : "[EN]",
          \ "dup" : g:alpaca_english_enable_duplicate_candidates,
          \ "info": record[2],
          \ }
    call add(res, can)
  endfor

  return res
endfunction"}}}

function! s:source.gather_candidates(context) "{{{
  if exists('b:alpaca_english_enable') ? 
          \ !b:alpaca_english_enable :
          \ !(neocomplete#is_text_mode() || neocomplete#within_comment())
          \ || a:context.complete_str !~ '^[[:alpha:]]\+$'
    return []
  endif

  if neocomplete#util#get_last_status()
    return []
  endif

  let result = alpaca_english#sqlite#get_record(a:context.complete_str)
  return s:to_canditates(result)
endfunction"}}}

function! neocomplete#sources#english#define() "{{{
  return alpaca_english#is_active() ? s:source : {}
endfunction"}}}

" vim: foldmethod=marker
