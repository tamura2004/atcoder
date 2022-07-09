s = gets.to_s
t = gets.to_s
puts s.size + 1 == t.size && t[0,s.size] == s ? "Yes" : "No"