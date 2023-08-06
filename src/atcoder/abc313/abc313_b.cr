n, m = gets.to_s.split.map(&.to_i)
ans = (1..n).to_a - Array.new(m){gets.to_s.split.map(&.to_i)[-1]}
puts ans.size == 1 ? ans[0] : -1