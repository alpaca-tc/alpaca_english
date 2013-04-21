function! alpaca_english#initialize() "{{{
  if exists('s:loaded_initialize')
    return 1
  endif
  let s:loaded_initialize = 1
  let g:path = expand("%")

  ruby << EOF
  def alp_require(path)
    require "#{VIM.evaluate('g:alpaca_english_root_dir')}/#{path}"
  end
  alp_require "lib/alpaca_english"
EOF
endfunction "}}}

function! alpaca_english#is_active() "{{{
  return has('ruby') && exists('g:alpaca_english_db_path') && g:alpaca_english_enable
endfunction"}}}

function! alpaca_english#print_error(string) "{{{
  echohl Error | echomsg a:string | echohl None
endfunction"}}}

function! alpaca_english#complete(word) "{{{
  call alpaca_english#initialize()

  try
    ruby << EOF
    AlpacaEnglish::Utils::VimUtils.vim_wrapper do
      word = VIM.evaluate("a:word")
      candidates = ::AlpacaEnglish::Models::Item.default.where("word like ?", "#{word}%").all
      candidates = candidates.to_neocomplcache
      ::VIM.command(%Q!let s:completion_words = #{candidates.to_json}!)
    end
EOF

    let g:debug = s:completion_words
    return s:completion_words

  " error処理
  catch /.*/
    " call alpaca_english#print_error('error occurred. please send to bug report for me.')
    return []
  endtry
endfunction "}}}
