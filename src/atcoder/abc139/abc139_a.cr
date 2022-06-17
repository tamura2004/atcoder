s = gets.to_s.chars
t = gets.to_s.chars
ans = s.zip(t).count(&.tally.keys.size.== 1)
pp ans
