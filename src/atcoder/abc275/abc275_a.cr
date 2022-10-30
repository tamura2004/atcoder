require "crystal/modint9"
a, b, c, d, e, f = gets.to_s.split.map(&.to_i64.to_m)
ans = a*b*c - d*e*f
pp ans
