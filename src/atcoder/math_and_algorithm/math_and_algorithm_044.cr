require "crystal/graph"
require "crystal/graph/dijkstra"

n, m = gets.to_s.split.map(&.to_i64)
g = n.to_g
m.times do
  g.read
end

ans = Dijkstra.new(g).solve.map do |v|
  v == Dijkstra::INF ? -1 : v
end
puts ans.join("\n")
