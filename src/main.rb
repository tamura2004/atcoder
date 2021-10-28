# [EXPERIMENTAL]
def convolution(a, b, mod: 998_244_353, k: 35, z: 99)
  n = a.size
  m = b.size
  return [] if n == 0 || m == 0

  raise ArgumentError if a.min < 0 || b.min < 0

  format = "%0#{k}x" # "%024x"
  sa = ""
  sb = ""
  a.each { |x| sa << (format % x) }
  b.each { |x| sb << (format % x) }

  zero = "0"
  s = zero * z + ("%x" % (sa.hex * sb.hex))
  i = -(n + m - 1) * k - 1

  Array.new(n + m - 1) { (s[i + 1..i += k] || zero).hex % mod }
end

s = gets.chomp.chars.map(&:to_i)
t = gets.chomp.chars.map(&:to_i)
n = s.size
m = t.size
rs = s.map { 1 - _1 }
rt = t.map { 1 - _1 }

st = convolution(s, rt.reverse)
ts = convolution(rs, t.reverse)

cnt = st.zip(ts).map(&:sum)
ans = cnt[m - 1..n - 1]
puts ans.min
