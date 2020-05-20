n = gets.to_i
a = Array.new(n){ gets.to_i }
dp = Array.new(n+2, 10**12)
dp[0] = 0
a.each do |a|
  i = dp.bsearch_index{ |v| a < v }
  dp[i] = a if a < dp[i]
end

i = dp.bsearch_index{ |v| n + 1 < v }
ans = n - i + 1
puts ans