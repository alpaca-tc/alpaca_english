require "json"
require "sqlite3"

require File.expand_path(File.dirname(__FILE__) + '/vim.rb')

module AlpacaEnglish #{{{
  def self.run #{{{
    # TODO instance_evalの形に出来ないかな。
    begin
      yield
    rescue => e
      VIM::message("error occurd. #{e.inspect}")
    end
  end #}}}
end #}}}
