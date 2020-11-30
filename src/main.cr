def div_ceil(a,b)
  (a + b - 1) // b
end

n,t = gets.to_s.split.map { |v| v.to_i64 }
a = gets.to_s.split.map { |v| v.to_i64 }
puts div_ceil(a.sum, t)