n,m = gets.to_s.split.map { |v| v.to_i64 }
a = gets.to_s.split.map { |v| v.to_i64 }
mod = gets.to_s.to_i64

dp = Array.new(n+1){ Array.new(m+1,0) }
(n+1).times do |i|
  dp[i][0] = 1 
end
n.times do |i|
  1.upto(m) do |j|
    if j - 1 - a[i] >= 0
      dp[i+1][j] = dp[i+1][j-1] + dp[i][j] - dp[i][j-1-a[i]]
    else
      dp[i+1][j] = dp[i+1][j-1] + dp[i][j]
    end
  end
end

pp dp