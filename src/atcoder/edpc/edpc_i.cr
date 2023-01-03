# 確率DP
# dp[i番目まで投げた][j表の数] := 確率
# dp[i+1][j+1] += dp[i][j] * a[i]
# dp[i+1][j] += dp[i][j] * (1 - a[i])
# dp <- 0.0_f64
# dp[-1][(n+1)//2..]が答え

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_f64)
dp = make_array(0.0_f64, n + 1, n + 1)
dp[0][0] = 1.0_f64

n.times do |i|
  (0...n).each do |j|
    2.times do |omote|
      jj = j + omote
      p = omote == 1 ? a[i] : (1.0_f64 - a[i])
      dp[i + 1][jj] += dp[i][j] * p
    end
  end
end

ans = dp[-1][n//2 + 1..].sum
pp ans
