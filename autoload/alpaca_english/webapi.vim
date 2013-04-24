let s:cache = {}

function! s:validate_configure(configure) "{{{
  " TODO
  return 1
endfunction"}}}

function! s:get_result_as_json(configure) "{{{
  ruby << EOF
  AlpacaEnglish.run do
    require 'httparty'
    require 'json'

    configure = VIM.evaluate("a:configure")
    url = configure["url"]
    opts = configure["opts"]
    response = HTTParty.get(url, query: opts)

    json = JSON.parse(response.body)
    VIM.let("json", json)
  end
EOF

  return json
endfunction"}}}

function! alpaca_english#webapi#search_with_configure(configure) "{{{
  try
    return s:get_result_as_json(a:configure)
  catch /.*/
    echomsg "error occured"
    return {}
  endtry
endfunction"}}}
