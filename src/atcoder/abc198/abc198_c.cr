r,x,y = gets.to_s.split.map(&.to_i64)
quit 2 if x ** 2 + y ** 2 < r ** 2
ans = (Math.sqrt(x ** 2 + y ** 2) / r).ceil.to_i64
pp ans
