require "crystal/modint9"
require "crystal/tree"
require "crystal/tree/depth"

n = gets.to_s.to_i
g = Tree.new(n)
(n-1).times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv
end

depth = Depth.new(g).solve
v = n.times.max_by do |i|
  depth[i]
end

depth = Depth.new(g).solve(v)
dia = depth.max
cnt = depth.count(dia)
pp dia
pp cnt

g.debug

