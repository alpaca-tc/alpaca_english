module VIM
  # escape ruby object
  def self.let(name, value)
    enc = evaluate("&encoding")
    parsed = value.to_json.to_s.encode(enc)
    command("let #{name} = #{parsed}")
  end

  def self.debug(name_or_message, message = nil)
    name = message ? name_or_message : "_"
    message ||= name_or_message
    let("g:alpaca_english#debug.#{name}", message)
  end
end
