require "crystal/matrix"

h, w, n = gets.to_s.split.map(&.to_i64)
m = Matrix(Int32).new(h.y + w.x, 0)

p = 0.x + 0.y
v = 0.x - 1.y

n.times do
  if m[p] == 0
    m[p] = 1
    v *= 1.y
    p += v
    p = ((p.x) % w).x + ((p.y) % h).y
  else
    m[p] = 0
    v *= -1.y
    p += v
    p = (p.x % w).x + (p.y % h).y
  end
end

puts m.a.map(&.map { |c| c == 0 ? '.' : '#'}.join).join("\n")
