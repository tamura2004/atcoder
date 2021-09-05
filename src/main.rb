n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i }
ans = a.zip(1..).sort(&:last).map(&:first)
puts ans.join(" ")
