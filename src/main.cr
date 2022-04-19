require "complex"

n = gets.to_s.to_i
x0,y0 = gets.to_s.split.map(&.to_i64)
x2,y2 = gets.to_s.split.map(&.to_i64)

z0 = y0.i + x0
z2 = y2.i + x2

zc = (z0 + z2) / 2

th = Math::PI * 2 / n
r = Math.sin(th).i + Math.cos(th)

z1 = (z0 - zc) * r + zc

puts "#{z1.real} #{z1.imag}"