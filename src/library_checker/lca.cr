require "crystal/graph/h_l_decomposition"
require "crystal/graph"

n, q = gets.to_s.split.map(&.to_i64)
g = n.to_g
p = gets.to_s.split.map(&.to_i)
p.zip(1..n).each do |(pv, v)|
  g.add pv, v, both: true, origin: 0
end
hld = HLDecomposition.new(g, 0)

q.times do
  v, nv = gets.to_s.split.map(&.to_i)
  pp hld.lca(v, nv)
end
