a = gets.to_s.split.map(&.to_i).sort
ans = a[0] + a[-1] - a[1] * 2
puts %w(Yes No)[ans.sign]
