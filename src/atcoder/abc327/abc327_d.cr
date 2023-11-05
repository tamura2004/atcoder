n,m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

require "crystal/graph"
require "crystal/graph/bipartite"

g = n.to_g
m.times do |i|
  g.add a[i], b[i]
end

begin
  Bipartite.new(g).solve
rescue
  quit :No
end

puts :Yes