n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
min = a.min

b = a.map(&.- min)

gcd = b.reduce do |x, y|
  x.gcd(y)
end

puts gcd == 1 ? 2 : 1

