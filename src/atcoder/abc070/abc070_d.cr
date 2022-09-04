require "crystal/graph"
require "crystal/graph/depth"

n = gets.to_s.to_i
g = Graph.new(n)
(n-1).times do
  g.read
end

q, k = gets.to_s.split.map(&.to_i)
k = k.pred

depth = Depth.new(g).solve(k)

q.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  pp depth[v] + depth[nv]
end
