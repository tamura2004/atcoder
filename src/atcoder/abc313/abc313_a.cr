n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

quit 0 if n == 1
ans = Math.max 0, a[1..].max - a.first + 1
pp ans