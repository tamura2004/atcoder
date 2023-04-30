n,a,b = gets.to_s.split.map(&.to_i64)
c = gets.to_s.split.map(&.to_i64)
n.times do |i|
  if c[i] == a + b
    quit i + 1
  end
end
