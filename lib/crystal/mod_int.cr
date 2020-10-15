record ModInt, v : Int64, mod : Int64 do
  def +(b)
    ModInt.new((v + b.to_i64 % mod) % mod, mod)
  end

  def -(b)
    ModInt.new((v + mod - b.to_i64 % mod) % mod, mod)
  end

  def *(b)
    ModInt.new((v * (b.to_i64 % mod)) % mod, mod)
  end

  def **(y)
    x = self
    ans = ModInt.new(1, mod)
    while y > 0
      ans *= x if y.odd?
      y >>= 1
      x *= x
    end
    return ans
  end

  def self.zero
    new(0)
  end

  def to_i64
    v
  end
end

