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

      result = ::AlpacaEnglish::Models::Item.default.where("word like ?", "#{word}%").all
      result = result.to_neocomplcache
      ::VIM.command(%Q!let s:completion_words = #{result.to_json}!)
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

function! alpaca_english#dict(args, context) "{{{
  call alpaca_english#initialize()

  let input = a:context["input"]

  if input == ""
    return [ { "word": "please input any word.", "is_dummy" : 1 }]
  endif

  try
    ruby << EOF
    AlpacaEnglish::Utils::VimUtils.vim_wrapper do
      input = VIM.evaluate("input")

      input_array = input.split(" ").map do |text|
        text.match(/[^a-zA-Z0-9]/) ? "%#{text}%" : "#{text}%"
      end
      conditions = input.split(" ").inject([]) do |sum, text|
        name = text.match(/[^a-zA-Z0-9]$/) ? "mean" : "word"
        sum << "#{name} like ? "
      end
      conditions = conditions.join(" or ")

      result = ::AlpacaEnglish::Models::Item.default.where([conditions, *input_array]).all
      result = result.to_unite
      ::VIM.command(%Q!let s:completion_words = #{result.to_json}!)
    end
EOF

    let g:debug3 = s:completion_words
    return s:completion_words

  " error処理
  catch /.*/
    " call alpaca_english#print_error('error occurred. please send to bug report for me.')
    return []
  endtry
endfunction "}}}
