s = gets.to_s.chomp.chars
n = s.size
ans = n.times.all? do |i|
  (i.even? && s[i] != 'L') ||
  (i.odd? && s[i] != 'R')
end

puts ans ? "Yes" : "No"
