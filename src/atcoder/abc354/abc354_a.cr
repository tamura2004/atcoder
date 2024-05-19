h = gets.to_s.to_i64
i = 0_i64
x = 0_i64
while x <= h
  x += 2_i64 ** i
  i += 1
end
pp i

