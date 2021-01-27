n, k, m = gets.to_s.split.map { |v| v.to_i64 }
dp = Array.new(k + 1) { Array.new(n + 1, 0_i64) }
dp[0][0] = 1_i64
1.upto(k) do |i|
  0.upto(n) do |j|
    if j - i >= 0
      dp[i][j] = dp[i-1][j] + dp[i][j-i]
    else
      dp[i][j] = dp[i-1][j]
    end
  end
end

puts dp[n][k]