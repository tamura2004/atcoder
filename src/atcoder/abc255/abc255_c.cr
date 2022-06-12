x, a, d, n = gets.to_s.split.map(&.to_i64)
x, d, a = {x, d, a}.map &.- if d < 0
tail = a + d * (n - 1)

quit a - x if x <= a
quit x - tail if tail <= x

x = (x - a) % d
ans = Math.min x, d - x

pp ans
