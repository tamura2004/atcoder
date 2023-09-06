alias Cap = Int64
alias V = Int32
require "crystal/flow_graph/dinic"
include FlowGraph

n, m = gets.to_s.split.map(&.to_i)
a, b, c = gets.to_s.split.map(&.to_i.pred)

g = Graph.new(n + 1)
m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  g.add v, nv, 1
  g.add nv, v, 1
end
g.add n, a, 1
g.add n, c, 1

num = Dinic.new(g).solve(n, b)
puts num >= 2 ? :Yes : :No
