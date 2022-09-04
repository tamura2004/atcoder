n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
ans = a.sum { |v| Math.max 80 - v, 0 }
pp ans
