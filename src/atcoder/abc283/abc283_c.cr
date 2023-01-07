s = gets.to_s
t = s.split(/[1-9]+/)
zero = s.count('0')
ans = s.size - zero + t.sum{|v|divceil(v.size, 2)}
pp ans