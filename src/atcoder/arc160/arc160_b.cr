require "crystal/modint9"
require "crystal/math"

t = gets.to_s.to_i64
t.times do
  n = gets.to_s.to_i64
  ans = 0.to_m
  (1_i64..Math.isqrt(n).to_i64).each do |y|
    ans += (y - 1) * (n // y - y) * 6
    ans += (n // y - y) * 3
    ans += (y - 1) * 3
    ans += 1
  end

  pp ans
end
