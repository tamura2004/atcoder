require "crystal/modint9"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
dp = Array.new(n, 0.to_m)
dp[0] = 1.to_m

n.times do |i|
  a[i].step(by: a[i], to: n - 1 - i) do |j|
    dp[i + j] += dp[i]
  end
end

pp dp

