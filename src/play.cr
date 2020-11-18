struct ModInt(M)
  getter v : Int64

  def initialize(v)
    @v = v.to_i64
  end

  def +(b)
    ModInt(M).new((v + b.to_i64 % M) % M)
  end

  def -(b)
    ModInt(M).new((v + M - b.to_i64 % M) % M)
  end

  def *(b)
    ModInt(M).new((v * (b.to_i64 % M)) % M)
  end

  def **(y)
    x = self
    ans = ModInt(M).new(1)
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

  def inspect
    v.inspect
  end
end

alias ModNum = ModInt(1_000_000_007_i64)

x = ModNum.zero
x += 100000000000
x += 100000000000
x += 100000000000
pp x