# 期待値DP

n = gets.to_s.to_i
dp = Array.new(n, 0.0)
dp[-1] = 3.5

(1...n).reverse_each do |i|
  (1..6).each do |j|
    if j < dp[i]
      dp[i-1] += dp[i] / 6.0
    else
      dp[i-1] += j / 6.0
    end
  end
end

pp dp[0]