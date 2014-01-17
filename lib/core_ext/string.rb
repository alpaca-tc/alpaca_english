class String
  def to_unite!
    self.instance_eval do
      extend ExtendForUniteString
    end

    self
  end

  def loose_empty?
    !self.match(/^\s*$/).nil?
  end
end

module ExtendForUniteString
  # もっと奇麗なコードに書き換える
  def is_japanese?
    # self.match(/[ぁ-んァ-ヴ一-龠亜-煕]/).nil?
    # self.match(/[ぁ-んァ-ヴ一-煕]/).nil?
    !self.is_english?
  end

  def is_english?
    !!self.match(/^[a-zA-Z]+$/)
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
end
