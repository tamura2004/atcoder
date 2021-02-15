x,y = gets.to_s.split.map { |v| v.to_i64 }
a = x * 3 - y
b = y * 3 - x
ans = a >= 0 && b >= 0 && a % 8 == 0 && b % 8 == 0
puts ans ? "Yes" : "No"
