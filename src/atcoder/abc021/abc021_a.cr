n = "%04b" % gets.to_s.to_i
ans = n.chars.map(&.to_i).zip([8,4,2,1]).select(&.first.== 1).map(&.last)
puts ans.size
puts ans.join("\n")

