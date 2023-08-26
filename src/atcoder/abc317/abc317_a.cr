n, h, x = gets.to_s.split.map(&.to_i64)
p = gets.to_s.split.map(&.to_i64)

n.times do |i|
  quit i + 1 if x <= h + p[i]
end
