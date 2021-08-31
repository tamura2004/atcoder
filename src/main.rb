n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i }
b = gets.to_s.split.map { |v| v.to_i }
ans = (a.max..b.min).size
puts ans
