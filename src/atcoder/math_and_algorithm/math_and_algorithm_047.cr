require "crystal/graph"
require "crystal/graph/bipartite"

n, m = gets.to_s.split.map(&.to_i64)
g = n.to_g
m.times do
  g.read
end

begin
  Bipartite.new(g).solve
  puts "Yes"
rescue
  puts "No"
end
