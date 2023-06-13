# dp[iターン以降で獲得できる期待値の最大]

n, t, p = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

dp = Array.new(n + 2, 0.0f64)

(0...n).reverse_each do |i|
  coin = a[i] * t // 100

  # 入れる
  pay = a[i] - coin + dp[i + 1]

  # 入れない
  not_pay = (p / 100) * (a[i] - coin + dp[i + 2]) + ((100 - p) / 100) * (a[i] + dp[i + 1])

  dp[i] = Math.max pay, not_pay
end

pp dp.first
