module AlpacaEnglish
  module DB
    def self.db
      @database ||= begin
        db_path = ::RubyVIM.get('g:alpaca_english_db_path')
        ::SQLite3::Database.new(db_path)
      end
    end

    def self.execute(sql)
      limit_value = RubyVIM.get('g:alpaca_english_max_candidates')
      sql += " limit #{limit_value}" unless sql.match(/limit/)
      # [review] - こまめにcloseすべき？それをするなら、blockを渡す形にしようか...
      db.execute(sql)
    end
  end
end
