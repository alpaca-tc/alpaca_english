function! s:escape(str) "{{{
  let str = a:str
  for [target, replace] in items(g:alpaca_english_say_ignore_char)
    let str = substitute(str, target, replace, 'g')
  endfor

  return str
endfunction"}}}

function! say#run() range "{{{
  let content = []
  call map(range(a:firstline, a:lastline), 'add(content, getline(v:val))')
  let str = s:escape(join(content, '. '))

  if executable('pkill')
    call alpaca_english#util#system('pkill -f say')
  endif

  call alpaca_english#util#system("say '" . str . "'")
endfunction"}}}
