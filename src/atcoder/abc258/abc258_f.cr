require "crystal/abc258"
include Abc258

t = gets.to_s.to_i64
t.times do
  b, k, sx,sy,gx,gy = gets.to_s.split.map(&.to_i64)
  f = F.new(b, k)
  pp f.dist(sx + sy.i, gx + gy.i)
end
