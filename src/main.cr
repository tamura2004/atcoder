require "crystal/digit_dp"

n = gets.to_s
dd = DigitDP.new(n)

dp = make_array(0_i64, dd.n + 1, 16, 2, 2, 2)
dp[0][0][0][0][0] = 1_i64

dd.each_with_leading_zero do |i, j, k, d, jj, kk|
  16.times do |s|  # leading 1の個数
    2.times do |t| # leading 1?
      ss = s
      ss += 1 if t == 1 && d == 1
      tt = ((j == ZERO || t == 1) && d == 1) ? 1 : 0

      next if 16 <= ss
      dp[i + 1][ss][jj][kk][tt] += dp[i][s][j][k][t]
    end
  end
end

ans2 = 0_i64
(1..n.to_i).each do |i|
  if a = i.to_s.match(/^1+/)
    ans2 += a[0]?.try(&.size) || 0
  end
end

pp ans2
