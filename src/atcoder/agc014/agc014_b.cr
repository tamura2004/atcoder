require "crystal/graph"
require "crystal/graph/in_deg"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

m.times do
  g.read
end

deg = InDeg.new(g).solve

puts deg.all?(&.even?) ? "YES" : "NO"