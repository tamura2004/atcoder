x,y,a,b,c = gets.to_s.split.map(&.to_i64)
p = gets.to_s.split.map(&.to_i64).sort.last(x)
q = gets.to_s.split.map(&.to_i64).sort.last(y)
r = gets.to_s.split.map(&.to_i64).sort

ans = (p+q+r).sort.last(x+y)
puts ans.sum
