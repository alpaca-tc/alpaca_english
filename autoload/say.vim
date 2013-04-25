" say.vim: A vim plugin by Koichiro Wada (wadako111@gmail.com)
" escape exclamation mark (!)
function! s:escape(str)
  let str = substitute(a:str, '[!"]', ".", "g")
  let str = substitute(str, "#", " hash ", "g")

  return str
endfunction

function! say#run() range
  let content = []
  call map(range(a:firstline, a:lastline), 'add(content, getline(v:val))')
  let str = s:escape(join(content, ". "))
  call alpaca_english#system(["say", '"', str, '"'])
endfunction
