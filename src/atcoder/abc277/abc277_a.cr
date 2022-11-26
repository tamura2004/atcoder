n,x = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

ans = a.zip(1..).select(&.first.== x).map(&.last).first
pp ans

