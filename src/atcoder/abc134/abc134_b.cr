n, d = gets.to_s.split.map(&.to_i64)
ans = divceil n, d << 1 | 1
pp ans