require "crystal/mod_int"

x = gets.to_s.to_i64
dp = make_array(1.to_m, x+1)
(3..x).each do |i|
  dp[i] = dp[i-1] + dp[i-2]
end
pp dp[x]