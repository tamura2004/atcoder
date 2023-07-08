a, b = gets.to_s.split.map(&.to_i64)
ans = (1..b-a).sum - b
pp ans