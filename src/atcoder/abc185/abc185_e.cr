n, m = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

INF = Int32::MAX//4

dp = make_array(INF, n + 1, m + 1)
n.succ.times { |i| dp[i][0] = i }
m.succ.times { |j| dp[0][j] = j }

n.times do |i|
  m.times do |j|
    if a[i] == b[j]
      chmin dp[i + 1][j + 1], dp[i][j]
    else
      chmin dp[i + 1][j + 1], dp[i][j] + 1 if dp[i][j] != INF
      chmin dp[i + 1][j + 1], dp[i + 1][j] + 1 if dp[i + 1][j] != INF
      chmin dp[i + 1][j + 1], dp[i][j + 1] + 1 if dp[i][j + 1] != INF
    end
  end
end

pp dp[-1][-1]
# pp dp

# dp[aのi文字目][bのj文字目] := 答えの最小値
# dp := inf
# dp[0][0] := 0
#
# a[i] == b[j] |
#  chmin dp[i+1][j+1], dp[i][j]
# a[i] != b[j] |
#  chmin dp[i+1][j+1], dp[i][j] + 1
#  chmin dp[i+1][j+1], min(dp[i+1][j],dp[i][j+1]) + 2
#
