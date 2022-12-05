n,k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i)
ans = n < k ? [0] * n : a.last(n-k) + [0] * k
puts ans.join(" ")

