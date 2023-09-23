require "crystal/geography"

x = Array.new(4) do
  Point.read
end

a = Segment.new(x[0], x[1])
b = Segment.new(x[2], x[3])
ans = a.intersect?(b)
puts ans ? "Yes" : "No"
