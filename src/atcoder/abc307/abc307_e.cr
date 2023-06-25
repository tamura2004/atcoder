require "crystal/modint9"

n, m = gets.to_s.split.map(&.to_i64)
dp = make_array(0.to_m, n + 1, 2)
dp[0][1] = 1.to_m

n.times do |i|
  2.times do |j|
    2.times do |jj|
      if j == 0 && jj == 0
        dp[i+1][jj] += dp[i][j] * (m - 2)
      elsif j == 1 && jj == 0
        dp[i+1][jj] += dp[i][j] * (m - 1)
      elsif j == 0 && jj == 1
        dp[i+1][jj] += dp[i][j]
      elsif j == 1 && jj == 1
      end
    end
  end
end
pp dp[-1][-1] * m
