n, x = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

ans = x.in?(a)
puts ans ? "Yes" : "No"
