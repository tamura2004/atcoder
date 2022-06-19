n = gets.to_s.to_i64
quit 0.5 if n.even?
puts (n - n // 2) / n
