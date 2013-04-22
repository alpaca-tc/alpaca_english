function! alpaca_english#is_active() "{{{
  return has('ruby') && exists('g:alpaca_english_db_path') && g:alpaca_english_enable
endfunction"}}}

function! alpaca_english#print_error(string) "{{{
  echohl Error | echomsg a:string | echohl None
endfunction"}}}

function! alpaca_english#get_record(cur_keyword_str)
  ruby << EOF
  require 'sqlite3'
  require 'json'

  db_path = VIM.evaluate("g:alpaca_english_db_path")
  input = VIM.evaluate("a:cur_keyword_str")
  limit = VIM.evaluate("g:alpaca_english_max_candidates")

  db = SQLite3::Database.new(db_path)

  sql_opt = "where word like '#{input}%' limit #{limit}"
  sql = "select * from items #{sql_opt}"
  res = db.execute(sql)
  db.close

  VIM.command("let s:complete = #{res.to_json}")
EOF

  return s:complete
endfunction
