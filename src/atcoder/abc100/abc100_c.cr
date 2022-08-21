n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
ans = a.sum(&.trailing_zeros_count.to_i64)
pp ans