require 'json'
require 'sqlite3'

require_relative 'ruby_vim'
require_relative 'sqlite/sqlite'
require_relative 'core_ext/string'

module AlpacaEnglish
  autoload :DB, 'alpaca_english/db'
  autoload :Unite, 'alpaca_english/unite'
  autoload :Completion, 'alpaca_english/completion'
end
