require "crystal/graph"
require "crystal/graph/dijkstra"
require "crystal/graph/reverse_graph_factory"

n, m, t = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

g = Graph.new(n)

m.times do
  g.read both: false
end

rg = ReverseGraphFactory.new(g).solve

go = Dijkstra.new(g).solve(0)
back = Dijkstra.new(rg).solve(0)

ans = n.times.max_of do |i|
  next 0_i64 if t < go[i] + back[i]

  a[i] * (t - go[i] - back[i])
end

pp ans
