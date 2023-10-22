# 区間DP
# 素な区間の統合
# dp[lo,hi] += dp[lo,md] * dp[md,hi] * combi(hi-lo, md-lo)
# 交差する区間は両方への拡張のみ！？
# dp[lo, hi] += dp[lo+1, hi-1] | 異なる場合のみ

require "crystal/modint9"
require "crystal/fact_table"

n = gets.to_s.to_i64
s = gets.to_s

# corner
quit 0 if n.odd?
quit 0 if s.count('M') != n // 2

dp = make_array(0.to_m, n+1, n+1)

(n+1).times do |i|
  dp[i][i] = 1.to_m
end

# 区間の長さの小さい方から更新
# 長さ偶数のみ
0.step(by: 2, to: n) do |len|
  (n+1).times do |lo|
    hi = lo + len
    next if n < hi

    # 素な区間の統合
    if 4 <= len
      (lo+2).step(by: 2, to: hi - 2) do |md|
        dp[lo][hi] += dp[lo][md] * dp[md][hi] * ((hi - lo) // 2).c((md - lo) // 2)
      end
    end

    # 区間が２以上
    if 2 <= len
      dp[lo][hi] += dp[lo+1][hi-1] if s[lo] != s[hi-1]
    end
  end
end

pp dp[0][n]