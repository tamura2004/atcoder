require "crystal/graph"
require "crystal/graph/rerooting"

n = gets.to_s.to_i64
g = n.to_g
(n-1).times do
  g.read
end

pp g