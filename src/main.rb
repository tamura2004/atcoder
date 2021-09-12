def solve(s)
  n = s.size
  left = s.rindex("D") || -1
  right = s.index("K") || n
  [0, right - left].max
end

n = gets.to_s.to_i
s = gets.chomp
pp solve(s)
