record ModInt, v : Int64 do
  MOD = 10_i64 ** 9 + 7
  def +(b); ModInt.new((v + b.to_i64 % MOD) % MOD); end
  def -(b); ModInt.new((v + MOD - b.to_i64 % MOD) % MOD); end
  def *(b); ModInt.new((v * (b.to_i64 % MOD)) % MOD); end
  def **(b)
    a = self
    ans = ModInt.new(1_i64)
    while b > 0
      ans *= a if b.odd?
      b //= 2
      a *= a
    end
    return ans
  end
  def self.zero; new(0); end
  def to_i64; v; end
  delegate to_s, to: @v
  delegate inspect, to: @v
end
