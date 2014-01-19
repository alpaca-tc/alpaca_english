let s:save_cpo = &cpo
set cpo&vim

let s:source = {
      \ 'name' : 'english',
      \ 'kind' : 'plugin'
      \ }

function! s:to_canditates(dict) "{{{
  let result = []
  for record in a:dict
    let candidate = {
          \ 'word' : record[1],
          \ 'abbr' : record[1]. ' '. record[2],
          \ 'menu' : '[EN]',
          \ 'dup' : g:alpaca_english_enable_duplicate_candidates,
          \ 'info': record[2],
          \ }
    call add(result, candidate)
  endfor

  return result
endfunction"}}}

function! s:source.get_keyword_list(cur_keyword_str)
  if get(b:, 'alpaca_english_enable', 0) &&
        \ (neocomplete#is_text_mode() && a:context.complete_str !~# '^[[:alpha:]]\+$')
    return []
  endif

  let result = alpaca_english#sqlite#get_record(a:cur_keyword_str)

  return s:to_canditates(result)
endfunction

function! neocomplcache#sources#english#define()
  return alpaca_english#is_active() ? s:source : {}
endfunction

function! neocomplcache#sources#english#completefunc(findstart, base) "{{{
  if a:findstart
    let [line, start] = [getline('.'), col('.') - 1]
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile

    return start
  endif

  return {
        \ 'words': map(
        \  alpaca_english#sqlite#get_record(a:base),
        \ '{"word": v:val[1], "abbr": v:val[1].": ".v:val[2], "info": v:val[3]}'), "refresh": "always"
        \ }
endfunction"}}}
