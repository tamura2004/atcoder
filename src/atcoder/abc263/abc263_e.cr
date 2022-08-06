require "crystal/modint9"
require "crystal/segment_tree"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
dp = make_array(0.to_m, n).to_st_sum

(0...n - 1).reverse_each do |i|
  dp[i] = (dp[i + 1..i + a[i]] + a[i] + 1) // a[i]
end

pp dp[0]
