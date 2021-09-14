struct Int
  def bit
    1_i64 << self
  end

  def on(b)
    self | b.bit
  end
end

x = 4
pp x.bit
pp x.on(1)
