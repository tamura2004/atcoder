record ModInt, v : Int64 do
  MOD = 998_244_353_i64
  def +(b); ModInt.new((v + b.to_i64 % MOD) % MOD); end
  def -(b); ModInt.new((v + MOD - b.to_i64 % MOD) % MOD); end
  def *(b); ModInt.new((v * (b.to_i64 % MOD)) % MOD); end
  def self.zero; new(0); end
  delegate to_i64, to: v
  delegate to_s, to: v
  delegate inspect, to: v
end

struct Int
  def to_m
    ModInt.new(to_i64)
  end
end

