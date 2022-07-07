k = gets.to_s.to_i64
h, m = k.divmod(60)
printf("%02d:%02d", 21 + h, m)