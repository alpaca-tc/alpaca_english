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

        conditions << if text.is_japanese?
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
  end #}}}
end
