# dp[i決][j配った] := 場合の数
# 遷移
# k = 0..a[i], dp[i+1][j+k] += dp[i][j]
# dp[i+1][j] = dp[i][j-a[i]..j]

require "crystal/mod_int"
require "crystal/fenwick_tree"

n, k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)
dp = Array.new(n+1) { FenwickTree(ModInt).new(k + 1) }
dp[0][0] = 1.to_m

n.times do |i|
  (0..k).each do |j|
    dp[i+1][j] = dp[i][j - a[i]..j]
  end
end

pp dp[-1][k]
