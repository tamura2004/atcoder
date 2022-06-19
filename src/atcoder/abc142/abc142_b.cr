n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
ans = a.count(&.>= k)
pp ans