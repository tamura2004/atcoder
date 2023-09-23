n = gets.to_s.chars.map(&.to_i)

ans = n.each_cons_pair.all? { |i, j| i > j }
puts ans ? "Yes" : "No"
