n, p, q = gets.to_s.split.map(&.to_i64)
d = gets.to_s.split.map(&.to_i64)
ans = Math.min p, q + d.min
pp ans