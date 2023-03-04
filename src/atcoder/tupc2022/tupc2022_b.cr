n, m, k = gets.to_s.split.map(&.to_i64)
a, b = Array.new(m) { gets.to_s.split.map(&.to_i64) }.transpose
a << n + 1
b << 0_i64
ans = 0_i64

h = b[0]
(0..m).each_cons_pair do |i, j|
  ans += Math.max(0i64, Math.min(a[j] - a[i], h - k))
  h = Math.max(0i64, h - (a[j] - a[i]))
  h += b[j]
  # pp! [i, h, ans]
end
pp ans
