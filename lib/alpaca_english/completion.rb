module AlpacaEnglish
  module Completion #{{{
    def self.complete_english(input)
      sql_opt = "where word like '#{input}%'"
      sql = "select * from items #{sql_opt}"
      AlpacaEnglish::DB.execute(sql)
    end
  end #}}}
end
