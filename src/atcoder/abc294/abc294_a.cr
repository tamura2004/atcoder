n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
ans = a.select(&.even?)
puts ans.join(" ")