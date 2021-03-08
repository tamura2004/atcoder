n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64).sort
ans = a.sum + a.max + n
pp ans
