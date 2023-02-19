n,m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64.pred)

ans = b.map{|i|a[i]}.sum
pp ans
