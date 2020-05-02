MOD = 10**9+7
n,k = gets.split.map &:to_i
dp = [0] * (k+1)

1.upto(k+1) do |i|
  dp[i] = (k/i).pow(n,MOD)
end

k.downto(0) do |i|
  (2*i).step(k+1,i) do |j|
    dp[i] -= dp[j]
    dp[i] %= MOD
  end
end

ans = 0
1.upto(k+1) do |i|
  ans += dp[i] * i
  ans %= MOD
end

puts ans