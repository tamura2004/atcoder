a,b = gets.to_s.split.map(&.to_i64)
ans = Math.max 0, a - b * 2
pp ansp