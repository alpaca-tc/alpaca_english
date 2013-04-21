function! alpaca_english#is_active() "{{{
  return has('ruby') && exists('g:alpaca_english_db_path') && g:alpaca_english_enable
endfunction"}}}

function! alpaca_english#enable()
  le
endfunction

function! alpaca_english#select_language() "{{{
  return 'ruby'
endfunction "}}}

function! alpaca_english#print_error(string) "{{{
  echohl Error | echomsg a:string | echohl None
endfunction"}}}
