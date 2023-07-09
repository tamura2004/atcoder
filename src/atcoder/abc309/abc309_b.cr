n = gets.to_s.to_i64
a = Array.new(n) { gets.to_s.chars.map(&.to_i) }
b = a.clone

vx = x = y = 0
vy = 1

4.times do
  n.pred.times do
    b[y][x] = a[y + vy][x + vx]
    y += vy
    x += vx
  end
  vx, vy = vy, -vx
end

puts b.map(&.join).join("\n")
