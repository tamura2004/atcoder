x, y, z = gets.split.map(&:to_i)
if x < 0
  x *= -1
  y *= -1
  z *= -1
end

if y < 0 || x < y || (z < y && 0 < z)
  pp x
elsif z < 0
  pp z.abs + (x - z).abs
else
  p -1
end
