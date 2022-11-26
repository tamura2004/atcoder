# 確率DP
# dp[位置i][何回目j]

require "crystal/modint9"

n, m, k = gets.to_s.split.map(&.to_i64)
mm = 1.to_m // m

dp = make_array(0.to_m, n + 1, k + 1)
dp[0][0] = 1.to_m

k.times do |j|
  jj = j + 1

  n.times do |i|
    (1..m).each do |w|
      ii = i + w
      ii = n * 2 - ii if n < ii

      dp[ii][jj] += dp[i][j] // * mm
    end
  end
end

ans = dp[-1].sum
pp ans

