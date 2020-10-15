
record ModInt, v : Int64 do
  MOD = 10_i64**9+7

  def +(b)
    (v + b.to_i64 % MOD) % MOD
  end

  def -(b)
    (v + MOD - b.to_i64 % MOD) % MOD
  end

  def *(b)
    (v * (b.to_i64 % MOD)) % MOD
  end

  def self.zero
    new(0)
  end

  def to_i64
    v
  end
end

x = ModInt.zero
x += 10000000000000
x *= 2
x *= 2
x *= 2
x *= 2
pp! x