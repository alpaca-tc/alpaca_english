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

function! s:source.get_keyword_list(cur_keyword_str) "{{{
  if (exists('b:alpaca_english_enable') && !b:alpaca_english_enable) ||
        \ !(neocomplcache#is_text_mode() || neocomplcache#within_comment())
        \ || a:cur_keyword_str !~ '^[[:alpha:]]\+$'
    return []
  endif

  " XXX pythonとか環境によって変えたいから、
  " ストラテジーパターンかファクトリーでメソッドを変えたい。
  " ダレカ、ウツクシイカキカタ、タノム
  let lang = alpaca_english#select_language()
  execute 'let result = alpaca_english#'.lang.'#complete#do(a:cur_keyword_str)'

  return result
endfunction"}}}

function! neocomplcache#sources#english#define() "{{{
  return alpaca_english#is_active() ? s:source : {}
endfunction"}}}

" vim: foldmethod=marker
