s = gets.to_s.tr("ABCDE","01234").chars.map(&.to_i)
t = gets.to_s.tr("ABCDE","01234").chars.map(&.to_i)

a = (s[1] - s[0]).abs
b = (t[1] - t[0]).abs

c = a == 1 || a == 4 ? 1 : 0
d = b == 1 || b == 4 ? 1 : 0

puts c == d ? "Yes" : "No"
