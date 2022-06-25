a, b, c, d = gets.to_s.split.map(&.to_i64)
ans = [a * c, b * d, a * d, b * c].max
pp ans
