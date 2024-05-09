n, a, b = gets.to_s.split.map(&.to_i64)
ans = Math.min b, a * n
pp ans