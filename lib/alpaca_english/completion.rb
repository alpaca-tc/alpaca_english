module AlpacaEnglish
  module Completion #{{{
    def self.complete_thesaurus(file_path, filter, max=100)
      file = File.new(file_path, "r")
      result = []
      file.each_line do |line|
        line.strip!
        result.concat(line.split(/[, ]/)).uniq! if line.match filter
        break if result.length > max
      end
      file.close

      result
    end

    def self.complete_english(input)
      sql_opt = "where word like '#{input}%'"
      sql = "select * from items #{sql_opt}"
      AlpacaEnglish::DB.execute(sql)
    end
  end #}}}
end
