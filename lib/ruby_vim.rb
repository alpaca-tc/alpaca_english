module RubyVIM
  include VIM
  extend VIM

  def self.encode
    evaluate('&encoding')
  end

  def self.let(name, value)
    value = value.to_json.to_s.force_encoding(encode)
    command("let #{name} = #{value}")
  end

  def self.get(name)
    value = evaluate(name)
    value.is_a?(String) ? value.force_encoding(encode) : value
  end
end
