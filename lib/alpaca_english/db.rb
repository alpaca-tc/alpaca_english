module AlpacaEnglish
  module DB # {{{
    def self.db #{{{
      db_path = ::VIM.evaluate("g:alpaca_english_db_path")
      db = ::SQLite3::Database.new(db_path)
      db
    end #}}}
  end #}}}
end
