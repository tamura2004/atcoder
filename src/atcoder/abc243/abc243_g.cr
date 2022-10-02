a = gets.to_s.to_i64
b = gets.to_s.to_i64

if a == 1
  pp 100
else
  pp b // (1_i64 - a)
end
