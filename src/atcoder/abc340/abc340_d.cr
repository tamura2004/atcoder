require "crystal/graph"
require "crystal/graph/dijkstra"

n = gets.to_s.to_i64
g = n.to_g

(n-1).times do |v|
  a, b, nv = gets.to_s.split.map(&.to_i64)
  nv -= 1

  g.add v, v + 1, a, both: false, origin: 0
  g.add v, nv, b, both: false, origin: 0
end

ans = Dijkstra.new(g).solve[-1]
pp ans