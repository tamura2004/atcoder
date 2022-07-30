a, b, c = gets.to_s.split.map(&.to_i64).sort
# a <= b <= c
ans = c - a
quit -1 if b - ans < 0
ans += a
pp ans
