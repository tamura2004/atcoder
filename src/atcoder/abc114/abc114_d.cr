# 75 = 5^2*3
# p^74
# p^24*q^2
# p^14*q^4
# p^4*q^4*r^2

require "crystal/prime"
n = gets.to_s.to_i64
quit 0 if n < 10

cnt = Hash(Int64,Int64).new(0_i64)
(2i64..n).each do |i|
  i.prime_division.each do |p, r|
    cnt[p] += r
  end
end

cnt = cnt.values
ans = 0_i64

# p^74
ans += cnt.count(&.>= 74)

# p^24*q^2
ans += cnt.count(&.>= 24) * (cnt.count(&.>= 2) - 1)

# p^14*q^4
ans += cnt.count(&.>= 14) * (cnt.count(&.>= 4) - 1)

# p^4*q^4*r^2
c4 = cnt.count(&.>= 4)
if c4 >= 2
  ans += c4 * (c4 - 1) // 2 * (cnt.count(&.>= 2) - 2)
end

pp ans
