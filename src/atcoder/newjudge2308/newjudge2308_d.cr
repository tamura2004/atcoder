require "crystal/graph"
require "crystal/graph/depth"

n1, n2, m = gets.to_s.split.map(&.to_i)
g = (n1 + n2).to_g
m.times do
  g.read
end

d1 = Depth.new(g).solve(0)
d2 = Depth.new(g).solve(n1 + n2 - 1)
ans = d1.max + d2.max + 1
pp ans
