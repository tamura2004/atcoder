s = gets.to_s.chomp
n = s.size
if s[0] == s[-1]
  puts n.even? ? "First" : "Second"
else
  puts n.odd? ? "First" : "Second"
end
