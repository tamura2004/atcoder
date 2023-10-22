# 区間DP
# dp[lo][hi] := [lo, hi)の場合の数
# 初期値：隣り合う二人の仲が良ければ１
# 遷移
# dp[lo][hi] += dp[lo+1][hi-1] * friend[lo][hi]
# dp[lo][hi] += dp[lo][md] * dp[md][hi] * c((hi-lo)//2, (md-lo)//2)

require "crystal/modint9"
require "crystal/fact_table"

alias I = Int32 | Int64

n, m = gets.to_s.split.map(&.to_i64)
fr = Hash(Tuple(I, I), I).new(0_i64)

m.times do
  a, b = gets.to_s.split.map(&.to_i64).sort
  fr[{a - 1, b}] = 1_i64
end

dp = make_array(0.to_m, n*2 + 1, n*2 + 1)
(n*2 + 1).times do |i|
  dp[i][i] = 1.to_m
end

2.step(by: 2, to: n * 2) do |len|
  (n*2).times do |lo|
    hi = lo + len
    next if n * 2 < hi

    # [lo, hi)の中で最後に取るペア[i, j)を固定して重複カウントを防ぐ
    lo.step(by: 2, to: hi - 2) do |i|
      (i+2).step(by: 2, to: hi) do |j|
        next if fr[{i, j}] != 1

        left  = dp[lo][i]
        mid   = dp[i+1][j-1]
        right = dp[j][hi]

        lc = (i - lo) // 2
        mc = (j - i - 2) // 2
        rc = (hi - j) // 2
        
        cnt = left * mid * right * (lc+mc+rc).c(lc)* (mc+rc).c(mc)
        # pp [lo, i, j, hi, left, mid, right, lc, mc, rc]
        dp[lo][hi] += cnt
      end
    end
  end
end

pp dp[0][-1]
