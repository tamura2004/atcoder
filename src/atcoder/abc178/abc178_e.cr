require "complex"

n = gets.to_s.to_i
a = Array.new(n) do
  x, y = gets.to_s.split.map(&.to_i64)
  x + y.i
end.map(&.* 1.i+1)

rmin, rmax = a.map(&.real).minmax
imin, imax = a.map(&.imag).minmax

ans = Math.max rmax - rmin, imax - imin
pp ans.to_i64
