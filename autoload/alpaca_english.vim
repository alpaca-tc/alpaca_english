function! alpaca_english#initialize() "{{{
  if exists('s:initialized')
    return 0
  endif
  let s:initialized = 1

  ruby << EOF
  plugin_root_path = VIM.evaluate('g:alpaca_english_plugin_root_dir')
  $:.unshift File.expand_path("#{plugin_root_path}/lib")

  require 'alpaca_english'
EOF
endfunction"}}}

function! alpaca_english#is_active() "{{{
  return has('ruby')
endfunction"}}}

function! alpaca_english#print_error(string) "{{{
  echohl Error | echomsg a:string | echohl None
endfunction"}}}


function! alpaca_english#completefunc(findstart, base)
  if a:findstart
    let [line, start] = [getline('.'), col('.') - 1]
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile

    return start
  endif

  let result = alpaca_english#sqlite#search(a:base)

  return neocomplete#sources#english#to_candidates(result)
endfunction
