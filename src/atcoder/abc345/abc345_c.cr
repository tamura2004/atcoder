# (n ** 2 - n) // 2通り
# 同じ文字がm個、m * (m - 1) // 2

s = gets.to_s
n = s.size.to_i64
cnt = s.chars.tally.values.map(&.to_i64)

ans = (n ** 2 - n) // 2
cnt.each do |m|
  next if m == 1
  ans -= m * (m - 1) // 2
end

if cnt.max > 1
  pp ans + 1
else
  pp ans
end
