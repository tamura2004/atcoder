# dp[i末尾の花の高さ] := 美しさの合計の最大値
# セグ木の区間最大

require "crystal/segment_tree"

n = gets.to_s.to_i
h = gets.to_s.split.map(&.to_i.pred)
a = gets.to_s.split.map(&.to_i64)
dp = n.to_st_max

n.times do |i|
  chmax dp[h[i]], dp[...h[i]] + a[i]
end

pp dp[0..]