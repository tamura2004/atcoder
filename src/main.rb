n = gets.to_s.to_i
ans = 0
n.times do
  a, b = gets.to_s.split.map { |v| v.to_i }
  ans += a * b
end

puts (ans * 105) / 100
