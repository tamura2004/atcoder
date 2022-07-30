t = gets.to_s.to_i64
t.times do
  ans = gets.to_s.split.map(&.to_i64).sum
  pp ans
end
