require 'mechanize'
module AlpacaEnglish
  module Unite #{{{
    # TODO リファクタリング
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

        VIM.debug(word)
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

    def self.alc_search(word) # {{{
      agent = ::Mechanize.new
      page = agent.get("http://eow.alc.co.jp/#{word}/UTF-8/")
      list = page.search("div[@id='resultsList']/ul/li")

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
