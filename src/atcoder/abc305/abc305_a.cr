n = gets.to_s.to_i64
case n % 5
when .<= 2
  puts n - (n % 5)
else
  puts divceil(n, 5) * 5
end
