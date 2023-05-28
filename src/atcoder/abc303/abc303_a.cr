n = gets.to_s.to_i64
s = gets.to_s
t = gets.to_s

ans = n.times.all? do |i|
  (s[i] == t[i]) ||
  (s[i] == '1' && t[i] == 'l') ||
  (s[i] == 'l' && t[i] == '1') ||
  (s[i] == '0' && t[i] == 'o') ||
  (s[i] == 'o' && t[i] == '0')
end

puts ans ? :Yes : :No