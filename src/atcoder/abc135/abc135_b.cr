n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

cnt = a.zip(1..).select{|i,j|i!=j}.size
ans = cnt == 2 || cnt == 0
puts ans ? "YES" : "NO"
