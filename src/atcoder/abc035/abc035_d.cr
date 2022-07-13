require "crystal/weighted_graph/dijkstra"
include WeightedGraph

n,m,t = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

g = Graph.new(n)
rg = Graph.new(n)

m.times do
  v,nv,cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost, both: false
  rg.add nv,v, cost, both: false
end

go = Dijkstra.new(g).solve
back = Dijkstra.new(rg).solve

ans = n.times.max_of do |i|
  next 0_i64 if t < go[i] + back[i]

  a[i] * (t - go[i] - back[i])
end

pp ans
