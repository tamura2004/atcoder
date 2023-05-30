n, m = gets.to_s.split.map(&.to_i64)

quit 0 if n == 1
quit -1 if m == 1

puts divceil(n - 1, m - 1)
