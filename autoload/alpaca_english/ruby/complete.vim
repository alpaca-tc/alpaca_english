" 初期化
function! s:initialize() "{{{
  ruby << EOF
  class Array
    def to_completely_json
      result = self.dup.each_with_object ([]) do |record, sum|
        dict =  {
          word: record.word,
          abbr: "#{record.word} #{record.mean}",
          menu: "[alp_en]", # TODO 形容詞、自動詞など表示出来たらいいね。
        }

        sum << dict
      end

      result.to_json
    end
  end
EOF
endfunction"}}}

function! alpaca_english#ruby#complete#do(word) "{{{
  " initialize
  if !exists('s:initialized')
    let s:initialized = 1
    call alpaca_english#ruby#initialize()
    call s:initialize()

    return []
  endif

  ruby << EOF
  begin
    word = VIM.evaluate("a:word")
    # limit =  VIM.evaluate("g:alpaca_english_limit")
    items = ::Item.where('word like ?', "#{word}%").limit(10).all
    VIM.command(%Q!let s:completion_words = #{items.to_completely_json}!)
  rescue => e
    VIM.command(%Q!let s:completion_words = []!)
  end
EOF

  if exists("s:completion_words") && type(s:completion_words) == type([])
    let g:test = s:completion_words
    return s:completion_words
  else
    return []
  endif
endfunction "}}}

" echo alpaca_english#where_like("nex")
