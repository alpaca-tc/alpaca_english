function! neocomplcache#_initialize_sources(source_names) "{{{
  " Initialize sources table.
  if s:loaded_all_sources && &runtimepath ==# s:runtimepath_save
    return
  endif

  let runtimepath_save = neocomplcache#util#split_rtp(s:runtimepath_save)
  let runtimepath = neocomplcache#util#join_rtp(
        \ filter(neocomplcache#util#split_rtp(),
        \ 'index(runtimepath_save, v:val) < 0'))

  for name in a:source_names
    if has_key(s:complfunc_sources, name)
            \ || has_key(s:ftplugin_sources, name)
            \ || has_key(s:plugin_sources, name)
      continue
    endif

    " Search autoload.
    for source_name in map(split(globpath(runtimepath,
          \ 'autoload/neocomplcache/sources/*.vim'), '\n'),
          \ "fnamemodify(v:val, ':t:r')")
      if has_key(s:loaded_source_files, source_name)
        continue
      endif

      let s:loaded_source_files[source_name] = 1

      let source = neocomplcache#sources#{source_name}#define()
      if empty(source)
        " Ignore.
        continue
      endif

      if source.kind ==# 'complfunc'
        let s:complfunc_sources[source_name] = source
        let source.loaded = 1
      elseif source.kind ==# 'ftplugin'
        let s:ftplugin_sources[source_name] = source

        " Clear loaded flag.
        let s:ftplugin_sources[source_name].loaded = 0
      elseif source.kind ==# 'plugin'
        let s:plugin_sources[source_name] = source
        let source.loaded = 1
      endif

      if (source.kind ==# 'complfunc' || source.kind ==# 'plugin')
            \ && has_key(source, 'initialize')
        try
          call source.initialize()
        catch
          call neocomplcache#print_error(v:throwpoint)
          call neocomplcache#print_error(v:exception)
          call neocomplcache#print_error(
                \ 'Error occured in source''s initialize()!')
          call neocomplcache#print_error(
                \ 'Source name is ' . source.name)
        endtry
      endif
    endfor

    if name == '_'
      let s:loaded_all_sources = 1
      let s:runtimepath_save = &runtimepath
    endif
  endfor
endfunction"}}}
