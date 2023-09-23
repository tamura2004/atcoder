n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
ans = a.reduce do |a, b|
  a.lcm(b)
end
pp ans
