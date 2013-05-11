function! alpaca_english#sqlite#get_record(cur_keyword_str) "{{{
  call alpaca_english#initialize()

  ruby << EOF
  AlpacaEnglish.run do
    input = VIM.evaluate("a:cur_keyword_str")
    limit = VIM.evaluate("g:alpaca_english_max_candidates")

    db = AlpacaEnglish::DB::db
    sql_opt = "where word like '#{input}%' limit #{limit}"
    sql = "select * from items #{sql_opt}"
    res = db.execute(sql)
    db.close

    VIM.let("s:complete", res)
  end
EOF

  return s:complete
endfunction"}}}

function! alpaca_english#sqlite#search_with_complex_conditions(args, context) "{{{
  call alpaca_english#initialize()
  let input = a:context["input"]

  try
    ruby <<EOF
    AlpacaEnglish.run do
      input = VIM.evaluate("input")
      limit = VIM.evaluate("g:alpaca_english_max_candidates")

      sql_opt = []
      sql_opt << AlpacaEnglish::Unite.parse_input(input)
      sql_opt << "limit #{limit}"
      sql = "select * from items #{sql_opt.flatten.join(" ")}"

      begin
        db = AlpacaEnglish::DB::db
        res = db.execute(sql)
        VIM.let("conditions", res)
      rescue => e
      ensure
        db.close
      end
    end
EOF
    return conditions
  catch /.*/
    call alpaca_english#print_error("error occured")
    return []
  endtry
endfunction"}}}

function! alpaca_english#sqlite#search_thesaurus_word(word) "{{{
  call alpaca_english#initialize()
  let word_list = alpaca_english#thesaurus#search_word(a:word)
  call insert(word_list, a:word)

  " 配列を、全てor( |)で繋ぐ
  let word_input = join(map(word_list, '"|".v:val'), " ")

  " 無理矢理送る
  return unite#sources#english#search_by_input(word_input)
endfunction"}}}
