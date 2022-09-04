require "crystal/graph"
require "crystal/graph/lca"

n, q = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

(n-1).times do
  v,nv = gets.to_s.split.map(&.to_i)
  g.add v, nv
end

lca = Lca.new(g, 0)
d = lca.depth

q.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  dist = d[v] + d[nv] - d[lca.solve(v,nv)] * 2
  puts dist.odd? ? "Road" : "Town"
end
