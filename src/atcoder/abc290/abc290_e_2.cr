n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64.pred)
b = Array.new(n, 0_i64)
a.each { |i| b[i] += 1 }

ans = 0_i64
((n + 1)//2).times do |lo|
  hi = n - 1 - lo
  cnt = (lo..hi).size.to_i64
  ans += (cnt - b[a[lo]]) * (lo + 1)
  ans += (cnt - b[a[hi]]) * (lo + 1)
  ans -= (lo + 1) if a[lo] != a[hi]
  b[a[lo]] -= 1
  b[a[hi]] -= 1
end

pp ans
