n = gets.to_s.to_i64
s = gets.to_s.chars

s.each_cons_pair do |x, y|
  quit :Yes if x == 'a' && y == 'b'
  quit :Yes if y == 'a' && x == 'b'
end

puts :No

