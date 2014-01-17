let s:source = {
      \ 'name' : 'english',
      \ 'kind' : 'manual',
      \ 'mark' : '[en]',
      \ 'max_candidates' : 15,
      \ 'min_pattern_length' : 3,
      \ 'is_volatile': 1,
      \ }

function! neocomplete#sources#english#define() "{{{
  return alpaca_english#is_active() ? s:source : {}
endfunction"}}}

function! s:to_canditates(dict) "{{{
  let res = []
  for record in a:dict
    let can = {
          \ 'word' : record[1],
          \ 'abbr' : record[1]. ' '. record[2],
          \ 'menu' : '[EN]',
          \ 'dup' : g:alpaca_english_enable_duplicate_candidates,
          \ 'info': record[2],
          \ }
    call add(res, can)
  endfor

  return res
endfunction"}}}

function! s:source.gather_candidates(context) "{{{
  if get(b:, 'alpaca_english_enable', 0) &&
        \ (neocomplete#is_text_mode() && a:context.complete_str !~# '^[[:alpha:]]\+$')

    return []
  endif

  let result = alpaca_english#sqlite#search(a:context.complete_str)

  return s:to_canditates(result)
endfunction"}}}
