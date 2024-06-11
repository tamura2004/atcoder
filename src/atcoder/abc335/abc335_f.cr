require "crystal/modint9"
R = 512

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

dp = Array.new(n, 0.to_m)
dp[0] = 1.to_m
dp2 = make_array(0.to_m, R, R)

n.times do |i|
  (1...R).each do |j|
    dp[i] += dp2[j][i % j]
  end
  if a[i] < R
    dp2[a[i]][i % a[i]] += dp[i]
  else
    (i + a[i]).step(by: a[i], to: n - 1) do |j|
      dp[j] += dp[i]
    end
  end
end

pp dp.sum
