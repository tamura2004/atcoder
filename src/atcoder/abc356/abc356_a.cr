n, l, r = gets.to_s.split.map(&.to_i64)

ans = (1..l-1).to_a + (l..r).to_a.reverse + (r+1...n+1).to_a
puts ans.join(' ')
