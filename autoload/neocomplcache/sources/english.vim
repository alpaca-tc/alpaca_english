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
  if (exists('b:alpaca_english_enable') && !b:alpaca_english_enable)
  " TODO 開発中だからいらね。
  " \ !(neocomplcache#is_text_mode() || neocomplcache#within_comment())
        \ || a:cur_keyword_str !~ '^[[:alpha:]]\+$'
    return []
  endif

  " XXX pythonとか環境によって変えたいから、ストラテジーパターンみたいにメソッ
  " ドを変えたい。
  " ダレカ、ウツクシイカキカタ、タノム
  let lang = g:alpaca_english_module_settings["complete"]
  execute 'let result = alpaca_english#'.lang.'#complete#do(a:cur_keyword_str)'
  return result
endfunction"}}}

function! s:is_active() "{{{
  return has('ruby') && exists('g:alpaca_english_db_path') && g:alpaca_english_enable
endfunction"}}}

function! neocomplcache#sources#english#define() "{{{
  return s:is_active() ? s:source : {}
endfunction"}}}

" vim: foldmethod=marker
