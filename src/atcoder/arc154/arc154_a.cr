require "crystal/modint9"

n = gets.to_s.to_i64
a = gets.to_s.chars.map(&.to_i)
b = gets.to_s.chars.map(&.to_i)

n.times do |i|
  a[i],b[i] = b[i],a[i] unless a[i] < b[i]
end
a.reverse!
b.reverse!

a_acc = 0.to_m
b_acc = 0.to_m

n.times do |i|
  a_acc += 10.to_m ** i * a[i]
  b_acc += 10.to_m ** i * b[i]
end

ans = a_acc * b_acc
pp ans
