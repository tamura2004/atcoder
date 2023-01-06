n, k = gets.to_s.split.map(&.to_i64)
c = gets.to_s.split.map(&.to_i64)
p = gets.to_s.split.map(&.to_i64)
cnt = c.zip(p).group_by(&.first).values.map(&.map(&.last).min).sort
quit -1 if cnt.size < k
puts cnt.first(k).sum

