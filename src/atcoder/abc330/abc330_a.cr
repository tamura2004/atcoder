n,l=gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

pp a.select(&.>= l).size
