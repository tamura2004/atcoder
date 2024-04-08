require "crystal/graph"
require "crystal/graph/rerooting"
require "crystal/complex"

n = gets.to_s.to_i64
g = n.to_g
(n-1).times do
    g.read
end

c = gets.to_s.split.map(&.to_i64)

f1 = ->(z : C) { z + z.y }
merge = ->(z : C, w : C) { z + w }
unit = 0.i
f2 = ->(z: C, v: Int32) { z + c[v].y }

rr = Rerooting(C).new(g, f1, merge, unit, f2)
pp rr.solve.map(&.x).min

