require "crystal/digit_dp"

n = gets.to_s

dd = DigitDP.new(n)

dp = make_array(0_i64, dd.n + 1, 16, 2,2)
dp[0][0][0][0] = 1_i64

dd.each do |i,k,d,kk|
  16.times do |j|
    2.times do |m|
      jj = j + ((d == 1 && m == 1) ? 1 : 0)
      next if jj >= 16
      mm = d == 1 ? 1 : 0
      dp[i+1][jj][kk][mm] += dp[i][j][k][m]
    end
  end
end

ans = 0_i64
16.times do |j|
  ans += dp[-1][j].map(&.sum).sum
end

pp dp[-1]
pp ans - 1
