function! alpaca_english#initialize() "{{{
  if exists('s:initialized')
    return 0
  endif
  let s:initialized = 1

  ruby << EOF
  require 'json'
  require 'sqlite3'

  module VIM #{{{
    # escape ruby object
    def self.let(name, value)
      enc = evaluate("&encoding")
      parsed = value.to_json.to_s.encode(enc)
      command("let #{name} = #{parsed}")
    end
  end #}}}

  module AlpacaEnglish #{{{
    def self.run #{{{
      # TODO instance_evalの形に出来ないかな。
      begin
        yield
      rescue => e
        VIM::message("error occurd. #{e.inspect}")
      end
    end #}}}
  end #}}}
EOF
endfunction"}}}

function! alpaca_english#is_active() "{{{
  return has('ruby') && exists('g:alpaca_english_db_path')
endfunction"}}}

function! alpaca_english#print_error(string) "{{{
  echohl Error | echomsg a:string | echohl None
endfunction"}}}
