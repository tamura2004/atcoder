a, b = gets.to_s.split(/x\^/).map(&.to_i64)
puts "#{a*b}x^#{b-1}"