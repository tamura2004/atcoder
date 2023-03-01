require "crystal/modint9"
require "crystal/fact_table"

# 時刻0にsにいる。時刻tにgにいる場合の数は？
def solve(s, g, t)
  return 0.to_m unless s - t <= g <= s + t
  return 0.to_m unless (t - (g - s).abs).even?

  k = (t - (g - s).abs) // 2
  t.c(k)
end

a,b,c,t = gets.to_s.split.map(&.to_i64)
a,b,c = [a,b,c].sort

lo = c - t
hi = a + t
quit 0 unless lo <= hi

ans = 0.to_m
(lo..hi).each do |i|
  ans += solve(a, i, t) * solve(b, i, t) * solve(c, i, t)
end

ans //= 2.to_m ** (t * 3)
pp ans
