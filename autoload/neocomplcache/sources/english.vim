let s:save_cpo = &cpo
set cpo&vim

let s:source = {
      \ 'name' : 'english',
      \ 'kind' : 'plugin'
      \ }

function! s:source.get_keyword_list(cur_keyword_str)
  if get(b:, 'alpaca_english_enable', 0) &&
        \ (neocomplete#is_text_mode() && a:context.complete_str !~# '^[[:alpha:]]\+$')
    return []
  endif

  let result = alpaca_english#sqlite#get_record(a:cur_keyword_str)

  return neocomplete#sources#english#to_candidates(result)
endfunction

function! neocomplcache#sources#english#define()
  return alpaca_english#is_active() ? s:source : {}
endfunction
