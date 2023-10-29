require "crystal/complex"

xa, ya, xb, yb, xc, yc = gets.to_s.split.map(&.to_i64)

a = xa + ya.i
b = xb + yb.i
c = xc + yc.i

a -= c
b -= c
c = 0.i

if b.x < 0
  a *= -1
  b *= -1
end

if b.y < 0
  a = a.conj
  b = b.conj
end

ans_1 = 0_i64

if b.x > 0
  if a.x < b.x
    ans_1 += (a - b).manhattan + 1 + b.x
  elsif a.x == b.x
  else
    ans_1 += (a - b).y.abs + a.x.abs - 1
  end
end

if b.y > 0
  ans_1 += b.y + 2
end

ans_2 = 0_i64

if b.y > 0
  if a.y <= b.y
    ans_2 += (a - b).manhattan + 1 + b.y
  else
    ans_2 += (a - b).x.abs + a.y.abs - 1
  end
end

if b.x > 0
  ans_2 += b.x + 2
end

ans = Math.min ans_1, ans_2
pp ans

