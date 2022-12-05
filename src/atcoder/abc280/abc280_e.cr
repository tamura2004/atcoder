require "crystal/modint9"

# 確率DP

n, p = gets.to_s.split.map(&.to_i64)
dp = Array.new(n+1, 0.to_m)

b = p.to_m // 100
a = 1.to_m - b

dp[0] = 0.to_m
dp[1] = 1.to_m

(2..n).each do |i|
  dp[i] = a * dp[i-1] + b * dp[i-2] + 1
end

puts dp[-1]