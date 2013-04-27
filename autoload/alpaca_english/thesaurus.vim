function! alpaca_english#thesaurus#search_word(word) "{{{
  " error check
  if g:alpaca_english_thesaurus_file == ""
    call alpaca_english#print_error("g:alpaca_english_thesaurus_file is empty")
    return []
  endif

  if empty(a:word)
    return []
  endif

  " initialize
  let s:thesaurus_cache = get(s:, 'thesaurus_cache', {})

  " memo
  if has_key(s:thesaurus_cache, a:word)
    return s:thesaurus_cache[a:word]
  endif

  ruby << EOF
  AlpacaEnglish.run do
    word = VIM.evaluate("a:word")
    file_path = VIM.evaluate("g:alpaca_english_thesaurus_file")
    max = VIM.evaluate("g:alpaca_english_max_candidates")
    thesaurus_words = AlpacaEnglish::Completion.complete_thesaurus(file_path, word, max)
    thesaurus_words ||= []
    VIM.let("complete", thesaurus_words)
  end
EOF

  let s:thesaurus_cache[a:word] = complete

  return s:thesaurus_cache[a:word]
endfunction"}}}
