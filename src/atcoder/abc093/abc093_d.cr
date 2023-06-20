require "crystal/math"

q = gets.to_s.to_i64
q.times do
  a, b = gets.to_s.split.map(&.to_i64).sort
  n = a * b
  k = Math.isqrt(a * b - 1)
  ans = k * 2
  ans -= 1 if k * (k + 1) > n - 1
  ans -= 1 if a <= k
  pp ans
end
