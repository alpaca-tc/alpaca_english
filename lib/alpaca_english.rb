require 'json'
require 'sqlite3'

require_relative 'ruby_vim'
require_relative 'sqlite/sqlite'
require_relative 'core_ext/string'

module AlpacaEnglish #{{{
  # [review] - 意味が分からない...
  def self.run #{{{
    # TODO instance_evalの形に出来ないかな。
    begin
      yield
    rescue => e
      RubyVIM::message("error occurd. #{e.inspect}")
    end
  end #}}}

  autoload :DB, 'alpaca_english/db.rb'
  autoload :Unite, 'alpaca_english/unite.rb'
  autoload :Completion, 'alpaca_english/completion.rb'
end #}}}
