function! alpaca_english#ruby#complete#do(word) "{{{
  call alpaca_english#ruby#initialize()

  try
    ruby << EOF
    AlpacaEnglish.if_ruby_wrapper do
      word = VIM.evaluate("a:word")
      candidates = ::Item.default.where("word like ?", "#{word}%").all
      candidates = candidates.to_neocomplcache
      VIM.command(%Q!let s:completion_words = #{candidates.to_json}!)
    end
EOF

    return s:completion_words

  " error処理
  catch /.*/
    call alpaca_english#print_error('error occurred. please send to bug report for me.')
    return []
  endtry
endfunction "}}}
