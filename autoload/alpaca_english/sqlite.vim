function! alpaca_english#sqlite#search(cur_keyword_str) "{{{
  call alpaca_english#initialize()

  ruby << EOF
  input = RubyVIM.get('a:cur_keyword_str')
  res = AlpacaEnglish::Completion.complete_english(input)
  RubyVIM.let('s:complete', res)
EOF

  return s:complete
endfunction"}}}

function! alpaca_english#sqlite#search_with_complex_conditions(args, context) "{{{
  call alpaca_english#initialize()
  let input = a:context['input']

  try
    ruby <<EOF
    input = RubyVIM.get('input')
    result = AlpacaEnglish::Unite.search_with_complex_conditions(input)
    RubyVIM.let('conditions', result)
EOF
    return conditions
  catch /.*/
    call alpaca_english#print_error('Error occured')
    return []
  endtry
endfunction"}}}
