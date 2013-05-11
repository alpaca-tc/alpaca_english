require "json"
require "sqlite3"

lib_root_path = File.expand_path(File.dirname(__FILE__))
require "#{lib_root_path}/vim.rb"
require "#{lib_root_path}/sqlite.rb"
require "#{lib_root_path}/string.rb"

module AlpacaEnglish #{{{
  def self.run #{{{
    # TODO instance_evalの形に出来ないかな。
    begin
      yield
    rescue => e
      VIM::message("error occurd. #{e.inspect}")
    end
  end #}}}

  lib_root_path = File.expand_path(File.dirname(__FILE__))
  autoload :DB, "#{lib_root_path}/alpaca_english/db.rb"
  autoload :Unite, "#{lib_root_path}/alpaca_english/unite.rb"
  autoload :Completion, "#{lib_root_path}/alpaca_english/completion.rb"
end #}}}
