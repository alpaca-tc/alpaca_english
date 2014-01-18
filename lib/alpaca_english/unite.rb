require 'mechanize'
module AlpacaEnglish
  module Unite #{{{
    # [todo] - これはひどい。時間がかかるから、最後にやろう。テストも書こう。
    def self.parse_input(input) #{{{
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
        conditions = if text == splited.first || text.is_or? then
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
      conditions << or_conditions.join(" or ")

      and_conditions = and_conditions.join(" and ")
      conditions = ["(", conditions, ")", "and", and_conditions].flatten unless and_conditions.empty?

      "where #{conditions.join(" ")}"
    end #}}}

    def self.search_with_complex_conditions(input)# {{{
      sql_opt = []
      sql_opt << parse_input(input)
      sql = "select * from items #{sql_opt.flatten.join(" ")}"

      AlpacaEnglish::DB.execute(sql) # result
    end# }}}

    def self.web_search(word) # {{{
      web_search_url = RubyVIM.get("g:alpaca_english_web_search_url")
      query_url = sprintf(web_search_url, word)
      query_xpath = RubyVIM.get("g:alpaca_english_web_search_xpath")

      agent = ::Mechanize.new
      page = agent.get(query_url)
      list = page.search(query_xpath)

      complete = []
      list.each do |element|
        res = {}
        element_array = element.text.split("\n").map { |s| s.chomp }
        element_array.delete_if { |s| s.empty? }
        res["example"] = element_array[0]
        res["transrate"] = element_array[1,element_array.length - 1].join("")

        complete << res
      end

      complete
    end# }}}

    def self.thesaurus_search(word)
    end
  end #}}}
end
