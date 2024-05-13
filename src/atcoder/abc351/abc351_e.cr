# 45度回転してx-y独立にマンハッタン
require "crystal/complex"

n = gets.to_s.to_i64
odd = [] of C
even = [] of C

n.times do
  z = C.read
  if (z.real + z.imag).odd?
    odd << z
  else
    even << z
  end
end

# pp! [odd, even]

odd.map! do |z|
  z * (1.y + 1.x)
end

even.map! do |z|
  z * (1.y + 1.x)
end

def solve(a)
  n = a.size
  b = (0...n-1).map do |i|
    a[i+1] - a[i]
  end

  (n-1).times.sum do |i|
    b[i] * (i + 1) * (n - 1 - i)
  end
end

odd_x = odd.map(&.real).sort
odd_y = odd.map(&.imag).sort
even_x = even.map(&.real).sort
even_y = even.map(&.imag).sort

ox = solve(odd_x)
oy = solve(odd_y)
ex = solve(even_x)
ey = solve(even_y)

# pp! [odd, even]
# pp! [odd_x,odd_y,even_x,even_y]
# pp! [ox,oy,ex,ey]

ans = ox+oy+ex+ey
pp ans // 2
