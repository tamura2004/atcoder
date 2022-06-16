n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

ans = a.sum{|v| 1.0 / v}
ans = 1.0 / ans

pp ans