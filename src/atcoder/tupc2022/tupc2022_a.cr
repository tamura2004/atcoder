n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

quit :Yes if n + 1 <= k

flag1 = a.first(k-1).sort.last == k - 1
flag2 = a.last(n-k+1).sort == a.last(n-k+1)
puts flag1 && flag2 ? :Yes : :No
