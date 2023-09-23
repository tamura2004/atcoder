n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

ans = n.times.sum do |i|
  a[i] / 3 + b[i] * 2 / 3
end

pp ans
