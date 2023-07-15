# 1..10の確率、上は無視する
require "crystal/modint9"
n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

dp = make_array(0.to_m, n + 1, 11)
dp[0][0] = 1.to_m

n.times do |i|
  (0..10).each do |j|      # 元
    (1..Math.min(a[i], 10-j)).each do |jj| # 出目
      jjj = j + jj
      next if 10 < jjj
      dp[i + 1][jjj] += dp[i][j]
    end
    dp[i+1][j] += dp[i][j] * a[i]
  end
end

pp dp
ans = dp[-1][10]
n.times do |i|
  ans //= a[i]
  ans //= 2
  pp! ans
end
pp ans
