n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
cnt = a.tally.values.sort
quit 0 if cnt.size <= k
ans = cnt.first(cnt.size - k).sum
pp ans

