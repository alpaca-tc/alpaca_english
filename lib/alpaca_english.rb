require 'json'
require 'sqlite3'

require 'vim.rb'
require 'sqlite/sqlite.rb'
require 'core_ext/string.rb'

module AlpacaEnglish #{{{
  # [review] - 意味が分からない...
  def self.run #{{{
    # TODO instance_evalの形に出来ないかな。
    begin
      yield
    rescue => e
      VIM::message("error occurd. #{e.inspect}")
    end
  end #}}}

  autoload :DB, 'alpaca_english/db.rb'
  autoload :Unite, 'alpaca_english/unite.rb'
  autoload :Completion, 'alpaca_english/completion.rb'
end #}}}
