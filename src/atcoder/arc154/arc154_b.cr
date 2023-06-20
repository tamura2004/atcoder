n = gets.to_s.to_i64
s = gets.to_s.chars.reverse
t = gets.to_s.chars.reverse

quit -1 if s.sort != t.sort

j = 0

(0...n).each do |i|
  while j < n && s[i] != t[j]
    j += 1
  end
  quit n - i if j == n
  j += 1
end
puts 0
