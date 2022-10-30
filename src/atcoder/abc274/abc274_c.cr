require "crystal/graph"
require "crystal/graph/depth"

n = gets.to_s.to_i
g = Graph.new(n*2+1)

a = gets.to_s.split.map(&.to_i64)

a.each_with_index do |v, i|
  v = v.pred
  nv1 = i * 2 + 1
  nv2 = i * 2 + 2
  g.add v, nv1, origin: 0
  g.add v, nv2, origin: 0
end

ans = Depth.new(g).solve(0)
puts ans.join("\n")