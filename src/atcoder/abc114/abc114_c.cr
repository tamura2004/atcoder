# 3進数と見なして数え上げ
n = gets.to_s.to_i64

ans = 0
now = 0

loop do
  s = now.to_s(4).tr("0123","0357")
  num = s.to_i64
  now += 1

  break if n < num
  next if s.count("0") > 0
  next if s.chars.uniq.size < 3
  ans += 1
end

pp ans