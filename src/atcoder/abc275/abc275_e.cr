# 確率DP
# 逆にたどる
# dp[ゴールまでi回][位置j]

require "crystal/modint9"

n, m, k = gets.to_s.split.map(&.to_i64)
mm = 1.to_m // m

dp = make_array(0.to_m, k + 1, n + 1)
dp[0][-1] = 1.to_m

k.times do |i|
  ii = i + 1

  n.times do |jj|
    (1..m).each do |w|
      j = jj + w

      if n < j
        j = n * 2 - j
      end

      dp[ii][jj] += dp[i][j] * mm
    end
  end
end

ans = dp.map(&.first).sum
pp ans

