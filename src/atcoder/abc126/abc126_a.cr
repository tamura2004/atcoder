n, k = gets.to_s.split.map(&.to_i64)
s = gets.to_s.chars

s[k-1] = (s[k-1].ord + 'a'.ord - 'A'.ord).chr
puts s.join