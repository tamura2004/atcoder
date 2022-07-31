n = gets.to_s.to_i64
s = gets.to_s

quit "No" if s == "AB"
quit "No" if s == "BA"
quit "Yes" if s == "AA"
quit "Yes" if s == "BB"

quit "Yes" if s[0] == 'B'
quit "Yes" if s[-1] == 'A'
puts "No"