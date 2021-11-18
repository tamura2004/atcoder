require "crystal/complex"
require "crystal/indexable"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

xs = a.map{|v| C.new v, -1 } + b.map{|v| C.new v, 1 }
xs.sort!

costs = xs.map(&.imag).cs
dists = [0_i64] + xs.map(&.real)

ans = Int64::MAX
