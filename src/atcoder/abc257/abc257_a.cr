n, x = gets.to_s.split.map(&.to_i64)
ord = (x - 1) // n
ans = ('A'.ord + ord).chr
puts ans