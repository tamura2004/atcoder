n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

ans = a.min_of(&.trailing_zeros_count)
pp ans