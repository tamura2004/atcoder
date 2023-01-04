require "crystal/matrix"
require "crystal/mod_int"

n, k = gets.to_s.split.map(&.to_i64)
z = C.unit(n)
m = Matrix.new(z) do
  gets.to_s.split.map(&.to_i.to_m)
end ** k
ans = z.times.sum { |w| m[w] }
pp ans
