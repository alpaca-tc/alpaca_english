# VIMを直接拡張しない。
module VIM
  # escape ruby object
  class << self
    def encode
      evaluate("&encoding")
    end

    def let(name, value)
      parsed = value.to_json.to_s.force_encoding(encode)
      command("let #{name} = #{parsed}")
    end

    def get(name)
      value = evaluate(name)
      if value.is_a? String
        value.force_encoding(encode)
      else
        value
      end
    end
  end
end
