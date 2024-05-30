# dp[i][j] := i番目の子供までにj個の飴を配る方法の数
# 初期化（0番目の子供に0個の飴を配る方法は1通り）
# dp[i+1][j] = dp[i][j-a[i]..j]

require "crystal/mod_int"
require "crystal/range_sum"

n, k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)
dp = Array.new(n + 1) { RangeSum(ModInt).new(k + 1) }
dp[0][0] = 1.to_m

n.times do |i|
  (0..k).each do |j|
    dp[i + 1][j] = dp[i][j - a[i]..j]
  end
end

pp dp[-1][k]
