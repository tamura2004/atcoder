n = gets.to_s.to_i64
quit :Yes if n == 1
a = gets.to_s.split.map(&.to_i64).sort

m = n // 2 + 1
ans = (m...n).all? do |i|
  j = i - m
  a[j] < a[i] && a[j+1] < a[i]
end
puts ans ? :Yes : :No