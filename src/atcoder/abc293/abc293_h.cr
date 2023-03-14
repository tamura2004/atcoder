# require "crystal/graph"
# require "crystal/graph/h_l_decomposition"
# require "crystal/union_find"

# n = gets.to_s.to_i
# gg = n.to_g
# (n - 1).times do
#   gg.read
# end

# hld = HLDecomposition.new(gg, 0)
# edges = gg.es.map { |v, nv, _, _| {hld.head[v], hld.head[nv]} }.select { |v, nv| v != nv }
# g = n.to_g
# edges.each do |v, nv|
#   g.add v, nv, origin: 0
# end

# dp = Array.new(n, 0_i64)

# dfs = uninitialized (Int32, Int32) -> Nil
# dfs = -> (v : Int32, pv : Int32) do
#   dp[v] = 1_i64
#   cnt = [0_i64,0_i64]
#   g.each(v) do |nv|
#     next if nv == pv
#     dfs.call(nv, v)
#     cnt = (cnt + [dp[nv]]).sort.last(2)
#   end
#   dp[v] += cnt.sum
# end
# dfs.call(0, -1)

# pp dp[0]

require "crystal/graph"
require "crystal/graph/bipartite_matching"

n = gets.to_s.to_i
g = (n*2).to_g
(n - 1).times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv + n
  g.add v + n, nv
end
pp g
# pp BipartiteMatching.new(g).solve
# cnt, _ = BipartiteMatching.new(g).solve
# pp n - cnt
