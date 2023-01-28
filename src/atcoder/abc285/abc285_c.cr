s = gets.to_s
n = s.size.to_i64
offset = 26_i64 * (26_i64 ** (n - 1) - 1) // 25

ans = 0_i64
a = s.chars.map(&.ord.- 'A'.ord)
a.each do |v|
  ans *= 26
  ans += v
end
pp ans + offset + 1