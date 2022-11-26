s = gets.to_s
t = gets.to_s

quit "No" if s.size < t.size

n = s.size
m = t.size
n.times do |i|
  quit "Yes" if s[i,m] == t
end

puts "No"
