n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i.pred)
b = gets.to_s.split.map(&.to_i64)
c = gets.to_s.split.map(&.to_i64)

ans = a.sum { |i| b[i] }
a.each_cons_pair do |i, j|
  ans += c[i] if i + 1 == j
end

pp ans
