require "crystal/modint9"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
digits = a.map { |x| x.to_s.size }

ans = 0.to_m
sum = a[0].to_m
(1...n).each do |i|
  ans += sum * (10.to_m ** digits[i]) + a[i] * i
  sum += a[i]
end

pp ans
