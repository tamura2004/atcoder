require "crystal/rbst"
require "crystal/tree/depth"
require "crystal/abc218/g/rec"
include Abc218::G

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

t = Tree.new(n)
(n-1).times do
  v, nv = gets.to_s.split.map(&.to_i)
  t.add v, nv
end

medians = Rec.new(t,a).solve
depth = Depth.new(t).solve

ans = Solve.new(t,depth,medians).solve
pp ans