function! s:initialize() "{{{
  if exists('s:initialized')
    return 0
  endif

  let s:initialized = 1

  call alpaca_english#initialize()

  ruby << EOF
  module SQLite3 #{{{
    class Database
      @@db_cache = {}

      # chaching
      alias_method :old_execute, :execute
      def execute(sql, bind_vars = [], *args, &block)
        begin
          return @@db_cache[sql] if @@db_cache[sql]

          result = old_execute(sql, bind_vars, *args, &block)
          @@db_cache[sql] = result
        rescue => e
          return []
        end
      end
    end
  end #}}}

  class String #{{{
    def is_japanese?
      !self.is_english?
    end

    def is_english?
      self.match(/[ぁ-んァ-ヴ一-龠亜-煕]/).nil?
    end

    def is_head?
      self[0] == '^'
    end

    def is_tail?
      self[-1] == '$'
    end

    def is_or?
      self[0] == '|'
    end

    def loose_empty?
      !self.match(/^\s*$/).nil?
    end
  end #}}}

  module AlpacaEnglish #{{{
    module DB # {{{
      def self.db #{{{
        db_path = ::VIM.evaluate("g:alpaca_english_db_path")
        db = ::SQLite3::Database.new(db_path)
      end #}}}
    end #}}}

    module Unite #{{{
      # TODO リファクタリング
      def self.parse_input(input) #{{{
        splited = input.split(" ")
        and_conditions = []
        or_conditions = []

        splited.each do |text|
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
  end #}}}
EOF
endfunction"}}}

function! alpaca_english#sqlite#get_record(cur_keyword_str) "{{{
  call s:initialize()

  ruby << EOF
  AlpacaEnglish.run do
    input = VIM.evaluate("a:cur_keyword_str")
    limit = VIM.evaluate("g:alpaca_english_max_candidates")

    db = AlpacaEnglish::DB::db
    sql_opt = "where word like '#{input}%' limit #{limit}"
    sql = "select * from items #{sql_opt}"
    res = db.execute(sql)
    db.close

    VIM.let("s:complete", res)
  end
EOF

  return s:complete
endfunction"}}}

function! alpaca_english#sqlite#search_with_complex_conditions(args, context) "{{{
  call s:initialize()
  let input = a:context["input"]

  try
    ruby <<EOF
    AlpacaEnglish.run do
      input = VIM.evaluate("input")
      limit = VIM.evaluate("g:alpaca_english_max_candidates")

      sql_opt = []
      sql_opt << AlpacaEnglish::Unite.parse_input(input)
      sql_opt << "limit #{limit}"
      sql = "select * from items #{sql_opt.flatten.join(" ")}"

      begin
        db = AlpacaEnglish::DB::db
        res = db.execute(sql)
        VIM.let("conditions", res)
      rescue => e
      ensure
        db.close
      end
    end
EOF
    return conditions
  catch /.*/
    call alpaca_english#print_error("error occured")
    return []
  endtry
endfunction"}}}
