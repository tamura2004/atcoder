require "crystal/graph/depth"

n = gets.to_s.to_i64
pa = gets.to_s.split.map(&.to_i64)
g = Graph.new(n)

pa.each_with_index do |nv, v|
  v += 1
  nv -= 1
  g.add v, nv, origin: 0
end

d = Depth.new(g).solve
pp d[-1]
