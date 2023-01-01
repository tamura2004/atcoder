# 挿入DP
# dp[i種類目まで使用して][j個の隣り合った場所がある]
# dp[0][0] = 1, other 0
# 遷移
# a[i]を1..a[i].sizeにk分割、a[i]-k分割が増える
# 分割パターンは、a[i] - 1からk-1を選ぶパターン
# kをlo, hiに分割（0<=lo<=j)
# jからlo個選ぶ、隣接はlo減る
# sum + 1 - jから、hi個選ぶ、隣接は減らない
# dp[-1][0]が答え

# a = [1,1,1,2,2,2,3,3,3]
# ans = [] of Array(Int32)
# a.each_permutation do |b|
#   next if (0...8).any?{|i|b[i] == b[i+1]}
#   ans << b
# end
# puts ans.uniq.size
# exit

require "crystal/mod_int"
require "crystal/fact_table"
a = gets.to_s.split.map(&.to_i)
n = a.sum
dp = make_array(0.to_m, 26+1, n)
dp[0][0] = 1.to_m
sum = 0

26.times do |i|
  ii = i + 1
  n.times do |j|
    if a[i].zero?
      dp[i+1][j] = dp[i][j]
      next
    end
    (1..a[i]).each do |k|
      jj = j + a[i] - k
      (0..j).each do |lo|
        hi = k - lo
        jjj = jj - lo
        other = sum + 1 - j
        next unless 0 <= jjj < n
        next unless 0 <= hi <= other
        dp[ii][jjj] += dp[i][j] * j.c(lo) * other.c(hi) * (a[i] - 1).c(k - 1)
      end
    end
  end
  sum += a[i]
end

# pp dp
pp dp[-1][0]