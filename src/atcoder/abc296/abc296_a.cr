n = gets.to_s.to_i64
s = gets.to_s

s.chars.each_cons_pair do |i,j|
  quit "No" if i == j
end
puts "Yes"