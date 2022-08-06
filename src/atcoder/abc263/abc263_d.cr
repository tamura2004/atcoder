require "crystal/indexable"

n,l,r = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

ans = Math.min(l, r) * n
INF = 1e17.to_i64
dp = make_array(INF, n+1, 2)
dp[0][0] = 0_i64
dp[0][1] = 0_i64

n.times do |i|
  ii = i + 1

  chmin dp[i+1][1], dp[i][1] + l
  chmin dp[i+1][0], dp[i][1] + a[i]
  chmin dp[i+1][0], dp[i][0] + a[i]

  chmin ans, dp[i+1][0] + (n - 1 - i) * r
  chmin ans, dp[i+1][1] + (n - 1 - i) * r
end

pp ans
# chmin ans
# pp ans
# pp dp[-1]
    