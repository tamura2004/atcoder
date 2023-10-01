n = gets.to_s.to_i64
s = gets.to_s
ans = s.index("ABC").try(&.+ 1) || -1
pp ans
