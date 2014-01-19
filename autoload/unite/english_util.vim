function! unite#english_util#get_input(context) "{{{
  let input = a:context['input']

  if empty(input)
    if g:alpaca_english_use_cursor_word
      let input = expand('<cword>')
    endif

    if empty(input)
      let input = input('input text -> ')
    endif
  endif

  return input
endfunction"}}}
