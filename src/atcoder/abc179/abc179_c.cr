require "crystal/segment_tree"
require "crystal/modint9"

n,k = gets.to_s.split.map(&.to_i64)
lr = Array.new(k) do
  l, r = gets.to_s.split.map(&.to_i64)
  {l,r}
end

dp = ST(ModInt).sum(n)
dp[0] = 1.to_m

n.times do |i|
  k.times do |j|
    l, r = lr[j]
    dp[i] += dp[i-r..i-l]
  end
end

pp dp[n-1]