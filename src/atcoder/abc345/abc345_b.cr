x = gets.to_s.to_i64
if x > 0
  puts divceil(x, 10)
else
  puts -(-x // 10)
end

