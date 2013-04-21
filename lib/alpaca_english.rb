require 'rubygems'
require 'active_record'
require 'sqlite3'
require 'json'
alp_require 'lib/alpaca_english/models'
alp_require 'lib/alpaca_english/scheme'
alp_require 'lib/alpaca_english/utils'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => VIM.evaluate("g:alpaca_english_db_path")
)

module AlpacaEnglish
  autoload :Models, 'models'
  autoload :Utils,  'utils'
  autoload :Scheme, 'scheme'
end

class Array
  include ::AlpacaEnglish::Utils::ActiveRecord
end
