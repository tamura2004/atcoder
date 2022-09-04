# 全て倒れている列を全探索
s = gets.to_s.chars.map(&.to_i)
a = Array.new(7, -1)

quit "No" if s[0] == 1

a[0] = s[6]
a[1] = s[3]
a[2] = s[1] | s[7]
a[3] = s[0] | s[4]
a[4] = s[2] | s[8]
a[5] = s[5]
a[6] = s[9]

ans = (1..5).any? do |i|
  a[i].zero? && a[...i].sum > 0 && a[i+1..].sum > 0
end

puts ans ? "Yes" : "No"