# 適当に根を取って根付き木とする
# 木DPをする
# dp[v頂点番号][i連結成分の数][j部分木の根を使う・使わない] := 場合の数
# vが葉であれば、dp[v][0][0] = 1, dp[v][1][1] = 1
# if 頂点を使う
# dp[v][i] = Σ dp[ch][j]

require "crystal/graph"
require "crystal/modint9"

n = gets.to_s.to_i
g = n.to_g
(n - 1).times do
  g.read
end

dfs = uninitialized (Int32, Int32) -> Array(Array(ModInt))
dfs = ->(v : Int32, pv : Int32) do
  dp = make_array(0.to_m, 2, 2)
  dp[0][0] = 1.to_m
  dp[1][1] = 1.to_m

  g.each(v) do |nv|
    next if nv == pv
    ret = dfs.call(nv, v)
    ndp = make_array(0.to_m, dp.size + ret.size - 1, 2)
    (0...dp.size).each do |i|
      (0...ret.size).each do |j|
        2.times do |i_use|
          2.times do |j_use|
            ii = i + j - (i_use & j_use)
            next unless ii >= 0
            ndp[ii][i_use] += dp[i][i_use] * ret[j][j_use]
          end
        end
      end
    end
    dp = ndp
  end
  dp
end
ans = dfs.call(0, -1)
puts ans.map(&.sum)[1..].join("\n")
