a, x, m = gets.split.map(&:to_i)
if a == 1
  puts x % m
else
  mm = m * (a - 1)
  puts a.pow(x, mm).pred % mm / a.pred
end
