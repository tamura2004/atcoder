# 挿入DP
# dp[iまで切った][j番目、直前の木]
# h[i] < h[i+1] -> iを先に切る
# dp[i+1][k] = sum dp[i][...k]
# h[i] > h[i+1] -> iを後に切る
# dp[i+1][k] = sum dp[i][k+1..]
# h[i] == h[i+1] -> どっちでも良い
# dp[i+1][k] = sum dp[i][...k] dp[i][k+1..]

require "crystal/mod_int"
require "crystal/segment_tree"

n = gets.to_s.to_i64
h = gets.to_s.split.map(&.to_i64)
dp = make_array(0.to_m, n, n)
dp[0][0] = 1.to_m
cs = dp[0].to_st_sum

(0...n-1).each do |i|
  (0..i+1).each do |k|
    if h[i] < h[i+1]
      dp[i+1][k] = cs[...k]
    elsif h[i] > h[i+1]
      dp[i+1][k] = cs[k..]
    else
      dp[i+1][k] =cs[0..]
    end
  end
  cs = dp[i+1].to_st_sum
end

pp cs[0..]