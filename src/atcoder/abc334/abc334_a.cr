b, g = gets.to_s.split.map(&.to_i64)
puts b > g ? "Bat" : "Glove"