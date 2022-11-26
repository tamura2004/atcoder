s = gets.to_s
ans = s.rindex('a').try(&.succ) || -1
pp ans