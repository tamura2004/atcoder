n, q = gets.to_s.split.map(&.to_i64)
dp = Array.new(n+1, 0)

q.times do
  l, r = gets.to_s.split.map(&.to_i)
  l -= 1
  dp[l] ^= 1
  dp[r] ^= 1
end

n.times do |i|
  dp[i+1] ^= dp[i]
end

puts dp[0...n].join
