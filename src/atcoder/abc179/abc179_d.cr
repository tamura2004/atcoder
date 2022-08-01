require "crystal/modint9"
require "crystal/segment_tree"

n,k = gets.to_s.split.map(&.to_i64)
lr = Array.new(k) do
  l,r = gets.to_s.split.map(&.to_i64)
  {l,r}
end

values = Array.new(n, 0.to_m)
dp = values.to_st_sum
dp[0] = 1.to_m

n.times do |i|
  k.times do |j|
    l, r = lr[j]
    dp[i] += dp[i-r..i-l]
  end
end

pp dp[n-1]