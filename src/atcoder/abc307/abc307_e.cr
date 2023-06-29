require "crystal/modint9"

n, m = gets.to_s.split.map(&.to_i64)
dp = make_array(0.to_m, n + 1, 2)
dp[0][1] = 1.to_m

n.times do |i|
  dp[i + 1][0] += dp[i][0] * (m - 2)
  dp[i + 1][0] += dp[i][1] * (m - 1)
  dp[i + 1][1] += dp[i][0]
end
pp dp[-1][-1] * m
