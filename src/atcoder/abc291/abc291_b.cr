n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).sort

puts a.first(n*4).last(n*3).sum / (n*3)
