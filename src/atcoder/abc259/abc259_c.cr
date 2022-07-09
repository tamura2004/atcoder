s = gets.to_s.chars.chunk(&.itself).to_a
t = gets.to_s.chars.chunk(&.itself).to_a

quit "No" if s.size != t.size
quit "No" if s.map(&.first) != t.map(&.first)

n = s.size
ans = n.times.all? do |i|
  s[i].last.size == t[i].last.size || (s[i].last.size < t[i].last.size && 2 <= s[i].last.size)
end

puts ans ? "Yes" : "No"
