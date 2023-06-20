a, b, k = gets.to_s.split.map(&.to_i64)
a_lo = a
a_hi = a + k - 1
b_lo = b - k + 1
b_hi = b

if a_hi < b_lo
  puts (a_lo..a_hi).join("\n")
  puts (b_lo..b_hi).join("\n")
else
  puts (a_lo..b_hi).join("\n")
end