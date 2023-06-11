n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

ans = a.zip(1..).sort.map(&.last).join(" ")
puts ans