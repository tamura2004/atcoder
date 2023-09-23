require "crystal/geography"

c = Array.new(2) do
  x, y, r = gets.to_s.split.map(&.to_i64)
  Circle.new(x + y.i, r)
end

ans = c[0].intersect?(c[1]) + 1
pp ans
