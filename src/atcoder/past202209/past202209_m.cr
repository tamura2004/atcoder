require "crystal/graph"
require "crystal/graph/dijkstra"

n, m = gets.to_s.split.map(&.to_i)
g = n.succ.to_g
a = gets.to_s.split.map(&.to_i64)

n.times do |v|
  g.add v, v.succ, a[v], both: false, origin: 0
  g.add v.succ, v, 0_i64, both: false, origin: 0
end

m.times do
  b,l,r = gets.to_s.split.map(&.to_i64)
  l = l.to_i.pred
  r = r.to_i
  g.add l, r, b, both: false, origin: 0
end

pp Dijkstra.new(g).solve[-1]
