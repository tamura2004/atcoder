n,a,b=gets.to_s.split.map(&.to_i)
ans = (1..n).select do |i|
  x = i.digits.sum
  (x - a) * (x - b) <= 0
end.sum

pp ans
