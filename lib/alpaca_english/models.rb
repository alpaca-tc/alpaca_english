module AlpacaEnglish# {{{
  module Models
    class Item < ActiveRecord::Base
      # after_initialize :set_mark
      # has_one :mark
      scope :default, lambda {
        count = VIM.evaluate("g:alpaca_english_max_candidates")
        limit(count)
      }

      # private
      # def set_mark
      #   self.mark ||= Mark.new(name: " ")
      # end
    end

    # class Mark < ActiveRecord::Base
    #   belongs_to :item

    #   scope :default, lambda {
    #     count = VIM.evaluate("g:alpaca_english_max_candidates") || 30
    #     limit(count)
    #   }
    # end
  end
end# }}}
