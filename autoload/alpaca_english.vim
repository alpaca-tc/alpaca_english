function! alpaca_english#initialize() "{{{
  if exists('s:initialized')
    return 0
  endif
  let s:initialized = 1

  if !alpaca_english#depend#test()
    return 0
  endif

  ruby << EOF
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
  if !exists("alpaca_english#enable")
    let alpaca_english#enable = 1
  endif

  return has('ruby') && exists('g:alpaca_english_db_path') && alpaca_english#enable
endfunction"}}}

function! alpaca_english#print_error(string) "{{{
  echohl Error | echomsg a:string | echohl None
endfunction"}}}

function! s:exists_vimproc() "{{{
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
  return s:exists_vimproc() ? vimproc#system_bg(a:commands) : system(commands)
endfunction"}}}
