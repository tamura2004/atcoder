# dpをする
# dp[i] = dp[i-1] + dp[j] : jは同じ色の最終位置。なければ足さない

require "crystal/mod_int"

n = gets.to_s.to_i
c = Array.new(n) do
  gets.to_s.to_i.pred
end

dp = make_array(0.to_m, n+1)
dp[0] = 1.to_m
ix = Array.new(200_000, -1)

n.times do |i|
  j = ix[c[i]]
  if j == -1 || j == i
    dp[i+1] = dp[i]
  else
    dp[i+1] = dp[i] + dp[j]
  end
  ix[c[i]] = i + 1
end

pp dp[-1]

