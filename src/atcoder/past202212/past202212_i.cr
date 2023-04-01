require "crystal/graph"
require "crystal/graph/tsort"

n, m = gets.to_s.split.map(&.to_i64)
g = n.to_g
m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv, both: false
end

puts Tsort.new(g).has_loop? ? :No : :Yes