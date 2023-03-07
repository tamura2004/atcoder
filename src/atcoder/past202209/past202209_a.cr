x,y,z = gets.to_s.split.map(&.to_i64)
ans = Math.max(y, x + z)
pp ans