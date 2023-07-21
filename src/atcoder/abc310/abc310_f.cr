# bitshiftによるインラインDPを思い出すこと
# 使っても使わなくても良い＝重ね合わせの状態
# 0かもしれないし5かもしれない=x＝0b10000100000
# xが２回 = x | (x << 5) = 0b10000100001
# ただしy > 10の時 x | (x << y) = xなのでまとめる
# n <= 100なので、O(N 2^11)で解ける

require "crystal/modint9"
require "crystal/indexable"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

dp = make_array(0.to_m, n + 1, 1<<11)
dp[0][1] = 1.to_m

n.times do |i|
  (1<<11).times do |j|
    1.upto(Math.min 10, a[i]) do |k|
      dp[i+1][(j | (j << k)) & 0b11111111111] += dp[i][j]
    end
    # a[i]の10より大きい個数
    next if a[i] <= 10
    dp[i+1][j] += dp[i][j] * (11..a[i]).size
  end
end

sum = 0.to_m
(1<<11).times do |j|
  sum += dp[-1][j] if j.bit(10) == 1
end

n.times do |i|
  sum //= a[i]
end

pp sum
