n, m = gets.to_s.split.map { |v| v.to_i }
s = gets.to_s
t = gets.to_s

dp = Array.new(n + 1) { Array.new(m + 1, 0_i64) }
n.times do |i|
  m.times do |j|
    if s[i] == t[j]
      dp[i + 1][j + 1] = dp[i][j] + 1
    else
      dp[i + 1][j + 1] = Math.max dp[i + 1][j], dp[i][j + 1]
    end
  end
end

pp dp[-1][-1]
