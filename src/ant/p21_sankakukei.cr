n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i }
ans = a.each_combination(3).max_of do |(i,j,k)|
  next 0 if i + j <= k
  next 0 if i + k <= j
  next 0 if k + j <= i
  i + j + k
end
puts ans