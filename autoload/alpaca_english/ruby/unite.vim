

function! alpaca_english#ruby#unite#do(args, context)
  call alpaca_english#ruby#initialize()
  let input = a:context["input"]

  if input == ""
    return [ { "word": "please input any text.", "is_dummy" : 1 } ]
  endif

  try
    ruby << EOF
    AlpacaEnglish.if_ruby_wrapper do
      args = VIM.evaluate("a:args")
      input = VIM.evaluate("input")

      candidates = ::Item.default.where("word like ?", "#{input}%").all
      candidates = candidates.to_unite
      VIM.command(%Q!let s:completion_words = #{candidates.to_json}!)
    end
EOF

    return s:completion_words

  " error処理
  catch /.*/
    call alpaca_english#print_error('error occurred. please send to bug report for me.')
    return []
  endtry
endfunction
