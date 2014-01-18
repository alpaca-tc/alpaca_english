module AlpacaEnglish
  module DB # {{{
    # [review] - 汚物
    def self.db #{{{
      db_path = ::RubyVIM.get("g:alpaca_english_db_path")
      ::SQLite3::Database.new(db_path)
    end #}}}

    # [review] - 抽象化しようか。。
    def self.execute(sql)
      limit = RubyVIM.get("g:alpaca_english_max_candidates")
      sql += " limit #{limit}" unless sql.match(/limit/)

      database = db
      res = database.execute(sql)
      database.close

      res
    end
  end #}}}
end
