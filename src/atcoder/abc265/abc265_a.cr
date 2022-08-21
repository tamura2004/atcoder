x,y,n = gets.to_s.split.map(&.to_i64)
# yを固定

ans = Int64::MAX
100.times do |i|
  next if n < i * 3
  chmin ans, y * i + (n - i * 3) * x
end

pp ans