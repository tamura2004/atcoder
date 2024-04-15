require "crystal/graph/tsort"
require "crystal/graph"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i.pred)
g = n.to_g

a.zip(0..).each do |nv, v|
  g.add v, nv, both: false, origin: 0
end

cnt = Tsort.new(g).solve
pp n - cnt.size