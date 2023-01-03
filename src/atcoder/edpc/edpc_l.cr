# 区間dp
# dp[lo][hi] := X - Y（先行の利得）
# dp <- 0
# 遷移
# 先行
# dp[lo][hi] <- max dp[lo+1][hi]+a[lo],dp[lo][hi-1]+a[hi]
# 後攻
# dp[lo][hi] <- min dp[lo+1][hi]-a[lo],dp[lo][hi-1]-a[hi]

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
dp = make_array(-1_i64, n + 1, n + 1)
(0..n).each { |i| dp[i][i] = 0_i64 }

dfs = uninitialized (Int32, Int32, Bool) -> Int64
dfs = ->(lo : Int32, hi : Int32, senko : Bool) do
  return dp[lo][hi] if dp[lo][hi] != -1_i64
  dp[lo][hi] = senko ? Math.max(
    dfs.call(lo + 1, hi, !senko) + a[lo],
    dfs.call(lo, hi - 1, !senko) + a[hi - 1],
  ) : Math.min(
    dfs.call(lo + 1, hi, !senko) - a[lo],
    dfs.call(lo, hi - 1, !senko) - a[hi - 1],
  )
end

ans = dfs.call(0, n, true)
pp ans
