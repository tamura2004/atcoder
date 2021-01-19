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

NON = 0
A__ = 1
AB_ = 2
ABC = 3

s = gets.to_s
n = s.size
dp = Array.new(n+1){ Array.new(4, ModInt.zero) }
dp[0][0] = ModInt.new(1)

n.times do |i|
  mul = s[i] == '?' ? 3 : 1
  4.times do |j|
    dp[i+1][j] += dp[i][j] * mul
  end

  dp[i+1][A__] += dp[i][NON] if s[i] == 'A' || s[i] == '?'
  dp[i+1][AB_] += dp[i][A__] if s[i] == 'B' || s[i] == '?'
  dp[i+1][ABC] += dp[i][AB_] if s[i] == 'C' || s[i] == '?'
end

puts dp[-1][-1]
