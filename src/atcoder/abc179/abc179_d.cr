require "crystal/modint9"
require "crystal/dual_segment_tree"

n,k = gets.to_s.split.map(&.to_i64)
lr = Array.new(k) do
  l,r = gets.to_s.split.map(&.to_i64)
  {l,r}
end

values = Array.new(n, 0.to_m)
dp = values.to_dual_st_add
dp[0] = 1.to_m

n.times do |i|
  k.times do |j|
    lo, hi = lr[j]
    dp[lo+i..hi+i] = dp[i]
  end
end

pp dp[n-1]