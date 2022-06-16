n, k = gets.to_s.split.map(&.to_i64)
s = gets.to_s.chars.chunk(&.itself).size
unhappy = Math.max 1_i64, s - k * 2
pp n - unhappy