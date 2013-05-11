function! alpaca_english#depend#test()
  ruby << EOF
  require "rubygems"
  depends = %w[json sqlite3]
  result = 1

  depends.each do |gem|
    # if Gem.source_index.find_name(gem).select { |source| source.name == gem }.empty?
    unless require gem
      VIM::message(<<-ERROR.gsub(/^\s*/, ''))
        Error occurd in elpaca_english. LoadError: cannot load such file -- #{gem}. You have to execute `gem install #{gem}` in the shell.")
      ERROR

      result = 0
    end
  end

  VIM.command("let result = #{result}")
EOF

  if !result
    let alpaca_english#enable = 0
  endif
  return result
endfunction
