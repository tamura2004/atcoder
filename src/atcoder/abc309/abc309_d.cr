require "crystal/graph"
require "crystal/graph/dijkstra"

n1, n2, m = gets.to_s.split.map(&.to_i64)
g1 = n1.to_g
g2 = n2.to_g

m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  if v <= n1
    g1.add v, nv
  else
    g2.add v - n1, nv - n1
  end
end

d1 = Dijkstra.new(g1).solve
d2 = Dijkstra.new(g2).solve(n2 - 1)

ans = d1.max + d2.max + 1
pp ans
