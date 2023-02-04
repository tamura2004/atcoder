n = gets.to_s.to_i64
n.times do
  a,b = gets.to_s.split.map(&.to_i64)
  pp a + b
end
