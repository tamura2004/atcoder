n, m, p = gets.to_s.split.map(&.to_i64)
quit 0 if n < m
pp (n - m) // p + 1
