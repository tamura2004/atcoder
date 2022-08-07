# 完全二分木上の区間DP
# dp1[i][j] := i回戦でjが勝った時、jを除き確定した利得の最大値
# dp2[i][j] := i回戦でjが勝って、次に負ける場合の利得の最大値
# i,jどちらも0-origin

require "crystal/segment_tree"

# i回戦jの別ブロック
def other(i,j)
  lo = (j ^ 1 << i) >> i << i
  hi = lo + (1 << i)
  {lo,hi}
end

h = gets.to_s.to_i64
n = 1i64 << h
c = Array.new(n) { gets.to_s.split.map(&.to_i64) }.transpose

dp1 = make_array(0_i64, h, n)
dp2 = Array.new(h){n.to_st_max}

n.times do |j|
  dp2[0][j] = c[0][j]
end

(1...h).each do |i|
  n.times do |j|
    lo, hi = other(i, j)
    dp1[i][j] = dp1[i-1][j] + dp2[i-1][lo...hi]
    dp2[i][j] = dp1[i][j] + c[i][j]
  end
end

pp dp2[-1][0..]
