require "crystal/indexable"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i.% 100).tally

ans = a[50] * (a[50] - 1) // 2
ans += a[0] * (a[0] - 1) // 2
(1...50).each do |i|
  ans += a[i] * a[100-i]
end

pp ans
