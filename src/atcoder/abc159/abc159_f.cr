require "crystal/modint9"

n, s = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

# dp[i番目まで決めた][合計j] := 場合の数
# ただしjがsを越えるならカウントしない

dp = make_array(0.to_m, n+1, s+1)
dp[0][0] = 1.to_m

n.times do |i|
  (0_i64..s).each do |j|
    2.times do |k|
      jj = k == 1 ? j + a[i] : j
      next if s < jj
      dp[i+1][jj] += dp[i][j]
    end
  end
end

ans = 0.to_m
(1...n).each do |w|
  n.times do |lo|
    hi = lo + w
    break if n < hi

    pp! [lo,hi,ans]
    ans += (dp[hi][-1] - dp[lo][-1]) * (lo + 1) * (n - hi + 1)
    pp! [lo,hi,ans]
  end
end

pp ans
