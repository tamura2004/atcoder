a,b = gets.to_s.split.map(&.to_i64)
ans = divceil(a,b)
pp ans