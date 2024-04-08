# 1---a a+1--a+b
n, a, b = gets.to_s.split.map(&.to_i64)
d = gets.to_s.split.map(&.to_i64.%(a+b)).uniq.sort
quit :Yes if d.size == 1

cnt = [] of Int64
d.each_cons_pair do |i, j|
    cnt << j - i
end
cnt << a + b + d[0] - d[-1]

puts cnt.max - 1 >= b ? :Yes : :No