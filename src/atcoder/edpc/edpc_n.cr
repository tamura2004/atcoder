# 区間DP
# dp[lo][hi] := 最小コスト
# dp[lo][hi] <- min lo<k<hi dp[lo][k] + dp[k][hi] + cs[lo,hi]

require "crystal/indexable"
n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
cs = a.cs
inf = Int64::MAX//4
dp = make_array(inf, n+1, n+1)
n.times do |i|
  dp[i][i] = 0_i64
  dp[i][i+1] = 0_i64
end

dfs = uninitialized (Int32, Int32) -> Int64
dfs = -> (lo : Int32, hi : Int32) do
  return 0_i64 if hi - lo <= 1
  return dp[lo][hi] if dp[lo][hi] != inf
  (lo+1..hi-1).each do |k|
    chmin dp[lo][hi], dfs.call(lo,k) + dfs.call(k,hi) + cs[hi] - cs[lo]
  end
  dp[lo][hi]
end

ans = dfs.call(0, n)
pp ans