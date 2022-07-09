require "crystal/complex"
require "crystal/union_find"

struct Circle
  getter c : C
  getter r : Int64

  def initialize(@c, @r)
  end

  def intersect?(t : Circle)
    dist = (c - t.c).abs2
    dist <= (r + t.r) ** 2 && (r - t.r) ** 2 <= dist
  end
end

n = gets.to_s.to_i64
sx,sy,tx,ty = gets.to_s.split.map(&.to_i64)
s = sx + sy.i
t = tx + ty.i

cs = Array.new(n) do
  x,y,r = gets.to_s.split.map(&.to_i64)
  Circle.new x + y.i, r
end

uf = n.to_uf
n.times do |i|
  n.times do |j|
    next unless i < j
    if cs[i].intersect?(cs[j])
      uf.unite i, j
    end
  end
end

si = -1
ti = -1
n.times do |i|
  si = i if (cs[i].c - s).abs2 == cs[i].r ** 2
  ti = i if (cs[i].c - t).abs2 == cs[i].r ** 2
end

ans = uf.same? si, ti
puts ans ? "Yes" : "No"
