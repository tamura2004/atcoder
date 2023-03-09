n = gets.to_s.to_i64
s = gets.to_s
t = [] of Char

n.times do |i|
  t = t.select{|c| c != s[i]}
  t << s[i]
end

puts t.join