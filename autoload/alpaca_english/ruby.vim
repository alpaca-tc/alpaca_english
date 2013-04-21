function! s:initialize() "{{{
  if exists('s:initialized')
    return 1
  endif
  let s:initialized = 1

  ruby << EOF
  require 'rubygems'
  require 'active_record'

  db_path =  VIM.evaluate("g:alpaca_english_db_path")

  ActiveRecord::Base.establish_connection(
      adapter: "sqlite3",
      database: db_path
  )

  class Item < ActiveRecord::Base
  end
EOF
endfunction"}}}

function! alpaca_english#ruby#initialize() "{{{
  call s:initialize()
endfunction"}}}
