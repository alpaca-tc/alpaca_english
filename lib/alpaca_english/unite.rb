require 'mechanize'
module AlpacaEnglish
  module Unite #
    def self.parse_input(input)
      # [todo] - これはひどい。時間がかかるから、最後にやろう。テストも書こう。
      splited = input.split(" ")
      and_conditions = []
      or_conditions = []

      splited.each do |text|
        # extend method for unite
        text.to_unite!

        # 不要な文字を削除
        word = text.gsub(/[$|! ]/, "")

        # 空なら処理しない
        next if word.loose_empty?

        # and なのか orなのか
        conditions = if text == splited.first || text.is_or?
          or_conditions
        else
          and_conditions
        end

        conditions << if text.is_japanese? then
                      "mean like '%#{word}%'"
                    else
                      "word like '#{word}%'"
                    end
      end

      conditions = []
      conditions << or_conditions.join(' or ')

      and_conditions = and_conditions.join(' and ')

      unless and_conditions.empty?
        conditions = ['(', conditions, ')', 'and', and_conditions].flatten
      end

      "where #{conditions.join(' ')}"
    end

    def self.search_with_complex_conditions(input)
      sql_opt = []
      sql_opt << parse_input(input)
      sql = "select * from items #{sql_opt.flatten.join(' ')}"

      AlpacaEnglish::DB.execute(sql)
    end

    def self.web_search(word)
      url = 'http://eow.alc.co.jp/%s/UTF-8/'
      query_url = sprintf(url, word)

      agent = ::Mechanize.new
      page = agent.get(query_url)
      list = page.search("div[@id='resultsList']/ul/li")

      candidates = []
      list.each do |element|
        result = {}
        element_array = element.text.split("\n").map { |s| s.chomp }
        element_array.delete_if { |s| s.empty? }
        result['example'] = element_array[0]
        result['transrate'] = element_array[1,element_array.length - 1].join('')

        candidates << result
      end

      candidates
    end
  end #
end
