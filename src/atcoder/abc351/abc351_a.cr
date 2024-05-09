a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

ans = a.sum - b.sum + 1
pp ans