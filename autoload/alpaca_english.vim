" [todo] - debug を削除する
let g:alpaca_english#debug = {}

function! alpaca_english#initialize() "{{{
  if exists('s:initialized')
    return 0
  endif
  let s:initialized = 1

  " [todo] - リファクタリングする
  ruby << EOF
  plugin_root_path = VIM.evaluate("g:alpaca_english_plugin_root_dir")
  $: << File.expand_path("#{plugin_root_path}/lib")
  require 'alpaca_english'
EOF

  return 1
endfunction"}}}

function! alpaca_english#is_active() "{{{
  " [todo] - リファクタリングする
  " [todo] - 多分、osyoさんの助言を見た方がいい
  if !exists("alpaca_english#enable")
    let alpaca_english#enable = 1
  endif

  " [todo] - is_activeの評価のタイミングが微妙だと思う。一旦neocompleteに組み込んでもいいと思う
  return has('ruby') && exists('g:alpaca_english_db_path') && alpaca_english#enable
endfunction"}}}

function! alpaca_english#print_error(string) "{{{
  " [todo] - Vitalを使う？
  echohl Error | echomsg a:string | echohl None
endfunction"}}}

function! s:exists_vimproc() "{{{
  " [todo] - Vitalを使う？2
  if !exists('s:exists_vimproc')
    try
      call vimproc#version()
    catch
    endtry

    let s:exists_vimproc =
          \ (exists('g:vimproc_dll_path') && filereadable(g:vimproc_dll_path))
          \ || (exists('g:vimproc#dll_path') && filereadable(g:vimproc#dll_path))
  endif

  return s:exists_vimproc
endfunction"}}}

function! alpaca_english#system(commands) "{{{
  " [todo] - Vitalを使う
  return s:exists_vimproc() ? vimproc#system_bg(a:commands) : system(commands)
endfunction"}}}
