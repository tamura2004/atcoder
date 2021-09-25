require "crystal/indexable"
require "crystal/weighted_graph/dijkstra"
include WeightedGraph

n,m,r,t = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
m.times do
  v,nv,cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost, origin: 1, both: true
end

g.debug


