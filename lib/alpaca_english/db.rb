module AlpacaEnglish
  module DB # {{{
    # [review] - 汚物
    def self.db #{{{
      db_path = ::VIM.get("g:alpaca_english_db_path")
      ::SQLite3::Database.new(db_path)
    end #}}}

    # [review] - 抽象化しようか。。
    def self.execute(sql)
      limit = VIM.get("g:alpaca_english_max_candidates")
      sql += " limit #{limit}" unless sql.match(/limit/)

      database = db
      res = database.execute(sql)
      database.close

      VIM.debug("last_sql", sql)
      res
    end
  end #}}}
end
