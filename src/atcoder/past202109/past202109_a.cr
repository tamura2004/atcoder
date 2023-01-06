a, b, c, d = gets.to_s.split.map(&.to_i64)
ans = Math.min a + b - c, d
pp ans
