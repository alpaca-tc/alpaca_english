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
  end #}}}
end
