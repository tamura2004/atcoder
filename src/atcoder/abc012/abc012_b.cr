n = gets.to_s.to_i64
h, m = n.divmod(3600)
m, s = m.divmod(60)
printf("%02d:%02d:%02d\n", h, m, s)
