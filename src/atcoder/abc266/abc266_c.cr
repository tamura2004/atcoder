require "crystal/geography"

a = Array.new(4) do
  x, y = gets.to_s.split.map(&.to_i64)
  Point.new(x,y)
end

b = Segment.new(a[0],a[2])
c = Segment.new(a[1],a[3])
ans = b.intersect?(c)
puts ans ? "Yes" : "No"