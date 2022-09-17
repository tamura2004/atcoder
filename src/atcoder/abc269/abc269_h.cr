require "crystal/graph"

n = gets.to_s.to_i
p = gets.to_s.split.map(&.to_i64)
g = Graph.new(n)
g.parse_plist([-1] + p)
puts g