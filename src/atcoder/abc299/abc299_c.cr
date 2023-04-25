n = gets.to_s.to_i64
s = gets.to_s
quit -1 if s == "o" * n
quit -1 if s == "-" * n
ans = s.chars.chunk(&.itself).to_a.select(&.[0].==('o')).map(&.last.size).max
pp ans
