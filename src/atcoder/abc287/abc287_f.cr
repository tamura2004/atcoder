# 適当に根を取って根付き木とする
# 木DPをする
# dp[v頂点番号][i連結成分の数][j部分木の根を使う・使わない] := 場合の数
# vが葉であれば、dp[v][0][0] = 1, dp[v][1][1] = 1
# if 頂点を使う
# dp[v][i] = Σ dp[ch][j]

require "crystal/graph"
require "crystal/modint9"

n = gets.to_s.to_i
m = (n-1)//2
g = n.to_g
(n-1).times do
  g.read
end

dp = make_array(0.to_m, n, m+1, 2)