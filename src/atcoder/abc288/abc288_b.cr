n, k = gets.to_s.split.map(&.to_i64)
a = Array.new(n){gets.to_s}
ans = a.first(k).sort
puts ans.join("\n")