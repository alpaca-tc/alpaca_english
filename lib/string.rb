class String #{{{
  def is_japanese?
    !self.is_english?
  end

  def is_english?
    # self.match(/[ぁ-んァ-ヴ一-龠亜-煕]/).nil?
    self.match(/[ぁ-んァ-ヴ一-煕]/).nil?
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
