# 線分との交差回数//2

require "crystal/geography"

ax, ay, bx, by = gets.to_s.split.map(&.to_i64)
a = Segment.new(ax, ay, bx, by)

n = gets.to_s.to_i64
xy = Array.new(n) do
  x, y = gets.to_s.split.map(&.to_i64)
  x + y.i
end
xy << xy[0]

bs = (0...n).map do |i|
  Segment.new(xy[i], xy[i + 1])
end

cnt = bs.count do |b|
  a.intersect?(b)
end

pp cnt // 2 + 1