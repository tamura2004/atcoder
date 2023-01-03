# dp[i決][j配った] := 場合の数
# 遷移
# k = 0..a[i], dp[i+1][j+k] += dp[i][j]
# dp[i+1][j] = dp[i][j-a[i]..j]

require "crystal/mod_int"
require "crystal/segment_tree"

n, k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)
dp = make_array(0.to_m, n+1, k+1)
dp[0][0] = 1.to_m
st = dp[0].to_st_sum

n.times do |i|
  (0..k).each do |j|
    dp[i+1][j] = st[j-a[i]..j]
  end
  st = dp[i+1].to_st_sum
end

pp dp[-1][k]