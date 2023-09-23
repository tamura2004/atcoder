require "crystal/complex"

a = Complex(Float64).read
b = Complex(Float64).read
c = Complex(Float64).read
dz = (c - b) / 1_000_000

ans = 1e100
1_000_001.times do |z|
  chmin ans, (a - (b + dz * z)).abs
end
pp ans
