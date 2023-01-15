# dp[i頂点の連結グラフ][j種類の最遠点がある]
# 頂点をk個、同じ距離に追加するとき
# dp[i+k][k] += dp[i][j] * (2 ** j - 1) ** k * (2 ** ((k-1)*k//2)) * c(n-i-1,k)
# dp[i][k] += dp[i-k][j] * (2 ** j - 1) ** k * (2 ** ((k-1)*k//2)) * c(n-i+k-1,k)

require "crystal/combination"

# a ** b (mod)
def modpow(a, b, mod)
  a = a.to_i64
  ans = 1_i64
  while b > 0
    if b.odd?
      ans *= a
      ans %= mod
    end
    b //= 2
    a *= a
    a %= mod
  end
  ans
end

n, m = gets.to_s.split.map(&.to_i64)
c = CombinationFactory.new(n, m).create
pw2 = Pow2Factory.new(n**2, m).create
dp = make_array(0_i64, n + 1, n + 1)
dp[1][1] = 1_i64

(2i64...n).each do |i|
  (1i64..i).each do |j|
    (1i64...i).each do |k|
      cnt = dp[i - k][j] * modpow(pw2[j - 1], k, m) % m
      cnt *= pw2[k * (k - 1) // 2]
      cnt %= m
      cnt *= c[n - i + k - 1][k]
      cnt %= m

      dp[i][k] += cnt
      dp[i][k] %= m
    end
  end
end

ans = 0_i64
(1..n).each do |j|
  cnt = dp[n - 1][j]
  ans += pw2[j - 1] * cnt
  ans %= m
end
pp ans
