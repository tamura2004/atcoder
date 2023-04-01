require "crystal/complex"

n, k = gets.to_s.split.map(&.to_i64)
x1, y1, x2, y2 = gets.to_s.split.map(&.to_i64)
s = x1.x + y1.y
t = x2.x + y2.y

free = 0
costs = [] of Int64

Array.new(n) do
  p, q, r, w = gets.to_s.split.map(&.to_i64)
  z = p.x + q.y
  if (s.dot(z) - r).sign != (t.dot(z) - r).sign
    costs << w
  else
    free += 1
  end
end

if k <= free
  puts 0
else
  costs.sort!
  puts costs.first(k - free).sum
end
