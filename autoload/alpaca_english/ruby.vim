" XXX 酷い。絵に書いたような糞コードw
" rubyで書いてrequireしようかな。
" Rubyのモジュール初期化"{{{
function! s:db_initialize() "{{{
  ruby << EOF
  AlpacaEnglish.if_ruby_wrapper do
    require 'rubygems'
    require 'json'
    require 'active_record'

    ActiveRecord::Base.establish_connection(
        adapter: "sqlite3",
        database: VIM.evaluate("g:alpaca_english_db_path")
    )
  end
EOF
endfunction"}}}

function! s:scheme_initialize() "{{{
  ruby << EOF
  AlpacaEnglish.if_ruby_wrapper do
    ActiveRecord::Schema.define do
      create_table :marks do |t|
        t.integer :mark_id
        t.references :item
        t.string :memo
        t.string :name
        t.timestamp
      end

      add_index :marks, :mark_id
      add_index :marks, :item_id
    end unless ActiveRecord::Base.connection.table_exists? 'marks'
  end
EOF
endfunction "}}}

function! s:active_model_initialize() "{{{
  ruby << EOF
  AlpacaEnglish.if_ruby_wrapper do
    class Item < ActiveRecord::Base
      after_initialize :set_mark
      has_one :mark

      scope :default, lambda {
        count = VIM.evaluate("g:alpaca_english_max_candidates") || 30
        limit(count)
      }

      private
      def set_mark
        self.mark ||= Mark.new(name: " ")
      end
    end

    class Mark < ActiveRecord::Base
      belongs_to :item

      scope :default, lambda {
        count = VIM.evaluate("g:alpaca_english_max_candidates") || 30
        limit(count)
      }
    end
  end
EOF
endfunction "}}}

" FIXME どこで定義するのが妥当だろうか。
function! s:core_ext_initialize() "{{{
  ruby << EOF
  AlpacaEnglish.if_ruby_wrapper do
    class Array
      ##
      # ActiveRecordで取得したレコードを、neocomplcache用に変換する
      def to_neocomplcache
        return [] unless self.first.respond_to? :word

        conditions = self.dup.each_with_object ([]) do |record, candidates|
          candidates.push ({
            word: record.word,
            abbr: "#{record.mark.name} #{record.word} #{record.send(:mean)}",
            menu: "[alp_en]" # TODO 形容詞、自動詞など表示出来たらいいね。
          })
        end
      end

      ##
      # ActiveRecordで取得したレコードを、unite用に変換する
      def to_unite
        return [] unless self.first.respond_to? :word

        conditions = self.dup.each_with_object ([]) do |record, candidates|
          candidates.push ({
            word: record.word,
            abbr: "#{record.word} #{record.send(:mean)}",
            source__data: {
              id: record.id,
              word: record.word,
              abbr: record.send(:mean),
            },
          })
        end
      end
    end
  end
EOF
endfunction "}}}

function! s:alpaca_english_initialize() "{{{
  ruby << EOF
  # XXX ネーミングが微妙すぎる...
  module AlpacaEnglish
    def self.if_ruby_wrapper
      begin
        yield
      rescue => e
        VIM::message(e)
      end
    end
  end
EOF
endfunction"}}}

function! alpaca_english#ruby#initialize() "{{{
  if exists('s:initialized')
    return 0
  endif

  call s:alpaca_english_initialize()
  call s:db_initialize()
  call s:scheme_initialize()
  call s:active_model_initialize()
  call s:core_ext_initialize()

  let s:initialized = 1
  return 1
endfunction"}}}
