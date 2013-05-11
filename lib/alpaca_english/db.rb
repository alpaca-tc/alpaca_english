module AlpacaEnglish
  module DB # {{{
    def self.db #{{{
      db_path = ::VIM.evaluate("g:alpaca_english_db_path")
      ::SQLite3::Database.new(db_path)
    end #}}}
  end #}}}
end
