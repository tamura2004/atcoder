require "crystal/weighted_tree"
require "crystal/xor_sum"

n = gets.to_s.to_i64
g = WeightedTree.new(n)

(n-1).times do
  v,nv,w = gets.to_s.split.map(&.to_i64)
  g.add v, nv, w, both: true, origin: 1
end

dp = Array.new(n, -1_i64)
dp[0] = 0_i64

g.bfs do |v, nv, w, q|
  next if dp[nv] != -1
  dp[nv] = dp[v] ^ w
  q << nv
end

ans = XORSum.new(dp).solve
pp ans
