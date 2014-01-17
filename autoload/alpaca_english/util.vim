function! s:exists_vimproc() "{{{
  " [todo] - Vitalを使う？2
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

function! alpaca_english#util#system(commands) "{{{
  return s:exists_vimproc() ? vimproc#system_bg(a:commands) : system(a:commands)
endfunction"}}}
