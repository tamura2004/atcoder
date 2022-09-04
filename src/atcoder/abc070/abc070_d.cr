require "crystal/graph/i_graph"
require "crystal/graph"
require "crystal/graph/lca"
require "crystal/graph/depth"

n = gets.to_s.to_i
g = Graph.new(n)
(n-1).times do
  v, nv, cost = gets.to_s.split.map(&.to_i)
  g.add v, nv, cost.to_i64
end

q, k = gets.to_s.split.map(&.to_i)
k = k.pred

depth = Depth.new(g).solve(k)

q.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  pp depth[v] + depth[nv]
end
