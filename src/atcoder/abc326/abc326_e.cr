require "crystal/modint9"
require "crystal/st"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
dp = Array.new(n+1, 0.to_m).to_st_sum
dp[0] = 1.to_m

(1..n).each do |i|
  dp[i] = dp[...i] // n
end

ans = (1..n).sum do |i|
  dp[i] * a[i-1]
end

pp ans