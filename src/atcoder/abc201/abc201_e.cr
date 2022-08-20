# 頂点対を考えてしまうと、O(N^2)でTLE
# 主客転倒で、各辺について考える
# ちょいまち、XORか
# [0] --x-- [1] --y-- [2]
#            |z
#           [3]
# のとき
# (x ^ z) + (x ^ y) + (y ^ z)を何とかしたい
#
# XORの足し算は引き算でもある
# 根を決めてルートからDPしていく
# ある頂点にたどり着いたとき、累積XORを取る、答えに足す
# 
# bit桁毎に考える、辺の重みは0,1のどちらか
# [0] --1-- [1] --1-- [2]
#            |0
#           [3]
# 根からの偶奇を求める
# even: 2, odd: 2
# 偶数同士、奇数同士の頂点間のXORはゼロ
# であるので、偶数頂点と奇数頂点のペアのみ加算する
#
# 上記をビットの桁位置として求める関数を作る

require "crystal/weighted_graph/graph"
require "crystal/mod_int"

n = gets.to_s.to_i64
g = Graph.new(n)

(n-1).times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost
end

ans = 0.to_m
pr = Problem.new(g)
(0...60).reverse_each do |i|
  ev, od = pr.solve(i)
  ans *= 2
  ans += od.to_m * ev
end
pp ans

class Problem
  getter g : Graph
  delegate n, to: g
  getter cnt : Array(Int32)

  def initialize(@g)
    @cnt = Array.new(n, 0)
  end

  def solve(d) # d := 桁位置
    cnt.fill(0)
    dfs(0, -1, d)
    {cnt.count(0), cnt.count(1)}
  end

  def dfs(v, pv, d)
    g[v].each do |nv, cost|
      next if pv == nv
      cnt[nv] = cnt[v] ^ cost.bit(d)
      dfs(nv, v, d)
    end
  end
end