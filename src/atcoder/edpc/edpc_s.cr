# 桁DP
require "crystal/mod_int"

a = gets.to_s.chars.map(&.to_i)
n = a.size
m = gets.to_s.to_i
dp = make_array(0.to_m, n + 1, m, 2)
dp[0][0][1] = 1.to_m

n.times do |i|
  2.times do |j|
    10.times do |d|
      next if j == 1 && a[i] < d
      jj = j & (d == a[i]).to_unsafe
      m.times do |k|
        kk = (k + d) % m
        dp[i+1][kk][jj] += dp[i][k][j]
      end
    end
  end
end

pp dp[-1][0].sum - 1


