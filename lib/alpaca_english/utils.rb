module AlpacaEnglish
  module Utils
    module VimUtils
      def self.vim_wrapper
        begin
          yield
        rescue => e
          VIM::message(e)
        end
      end
    end

    module ActiveRecord
      def to_neocomplcache
        return [] unless self.first.respond_to? :word

        self.dup.each_with_object([]) do |record, candidates|
          # TODO 形容詞、自動詞など表示出来たらいいね。
          candidates.push ({
            word: record.word,
            abbr: "#{record.word} #{record.send(:mean)}",
            menu: "[alp_en]"
          })
        end
      end

      # def to_unite
      #   return [] unless self.first.respond_to? :word
      #   conditions = self.dup.each_with_object ([]) do |record, candidates|
      #     candidates.push ({
      #       word: record.word,
      #       abbr: "#{record.word} #{record.send(:mean)}",
      #       source__data: {
      #       id: record.id,
      #       word: record.word,
      #       abbr: record.send(:mean),
      #     },
      #     })
      #   end
      # end
    end
  end
end
