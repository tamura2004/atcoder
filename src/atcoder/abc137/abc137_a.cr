a, b = gets.to_s.split.map(&.to_i64)
ans = [] of Int64
ans << a + b
ans << a - b
ans << a * b
pp ans.max