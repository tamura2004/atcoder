n = gets.to_s.to_i64
s = gets.to_s

pp s.split(/<+/).map(&.size).map { |x| x * (x + 1) // 2}.sum
