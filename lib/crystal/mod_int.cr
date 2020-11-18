struct ModInt(MOD)
  getter v : Int64

  def initialize(@v)
  end

  def +(b)
    ModInt.new((v + b.to_i64 % MOD) % MOD, MOD)
  end

  def -(b)
    ModInt.new((v + MOD - b.to_i64 % MOD) % MOD, MOD)
  end

  def *(b)
    ModInt.new((v * (b.to_i64 % MOD)) % MOD, MOD)
  end

  def **(y)
    x = self
    ans = ModInt.new(1, MOD)
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
