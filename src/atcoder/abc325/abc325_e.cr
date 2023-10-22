# vertex double dijkstra
require "crystal/graph"
require "crystal/graph/dijkstra"

n, a, b, c = gets.to_s.split.map(&.to_i64)
d = Array.new(n) { gets.to_s.split.map(&.to_i64) }

# g = 3.to_g
# g.add 1, 2, 100, both: false
# g.add 2, 3, 100, both: false
# pp Dijkstra.new(g).solve

g = (n*2).to_g
n.times do |v|
  n.times do |nv|
    next if v == nv

    g.add v, nv, d[v][nv] * a, both: false, origin: 0
    g.add v+n, nv+n, d[v][nv] * b + c, both: false, origin: 0
  end
end

n.times do |v|
  g.add v, v + n, 0_i64, both: false, origin: 0
end

depth = Dijkstra.new(g).solve(0)
pp Math.min(depth[n-1], depth[-1])