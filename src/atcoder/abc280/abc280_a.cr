h,w = gets.to_s.split.map(&.to_i64)
ans = 0
h.times do
  ans += gets.to_s.count('#')
end
pp ans