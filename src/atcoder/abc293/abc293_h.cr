require "crystal/graph"

n = gets.to_s.to_i
g = n.to_g
(n-1).times do
  g.read
end

pp g