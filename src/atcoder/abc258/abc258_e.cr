require "crystal/indexable"
require "crystal/graph"

n,q,x = gets.to_s.split.map(&.to_i64)
w = gets.to_s.split.map(&.to_i64)
ws = w.sum
m = x // ws

g = Graph.new(n+1)
seen = Set(Int32).new

cs = w.cs

v = 0
seen << 0
loop do
  nv = cs.bsearch_index(&.>= (x + cs[v]) % ws).not_nil!
  # pp! nv
  # nv -= n if nv > n
  g.add v, nv, origin: 0, both: false
  break if seen.includes?(nv)
  seen << nv
  v = nv
end

ro = Ro.new(g)

q.times do
  k = gets.to_s.to_i64
  i = ro.solve(k-1)
  j = ro.solve(k)
  # pp! [i,j,n,m]
  if i == j
    pp n * divceil(x,ws)
  elsif i < j
    pp m * n + j - i
  else
    pp (m + 1) * n + j - i
  end
end

# ρ法で問題を解く
#
# 状態遷移が出次数が全て1のDAGとみなせる場合
# 大きな状態遷移回数kに対して、O(N)で以下を求める
# goal : 最終位置
# path : ループ開始までの経路
# m : path上のループ開始位置
# hist : path上の訪問回数
#
# ```
# # [0] -> [1] -> [2] -> [3] -> [4]
# #                ^             |
# #                +-------------+
# g = Graph.new(5)
# g.add 0, 1, both: false, origin: 0
# g.add 1, 2, both: false, origin: 0
# g.add 2, 3, both: false, origin: 0
# g.add 3, 4, both: false, origin: 0
# g.add 4, 2, both: false, origin: 0

# ro = Ro.new(g).solve(9)
# ro.goal # => 3
# ro.n # => 5
# ro.m # => 2
# ro.path # => [0, 1, 2, 3, 4]
# ro.hist # => [1, 1, 3, 3, 2] # ループしない場合は hist.size <= path.size
# ```
class Ro
  getter g : Graph

  getter path : Array(Int32) # 移動経路
  getter seen : Array(Int32) # 最初に通過した順番
  getter n : Int32           # 経路の長さ
  getter m : Int32           # ループの開始点
  getter root : Int32

  def initialize(@g, @root = 0)
    @path = [] of Int32
    @seen = Array.new(g.n, -1)
    @n = -1
    @m = -1
    @goal = -1
    dfs(root, 0)
  end

  # rootからk回進んだゴール
  def solve(k, root = 0)
    k = k.to_i64

    if k < n # ループしない場合
      path[k]
    else
      path[m + (k - n) % (n - m)]
    end
  end

  def dfs(v, i)
    # 訪問済ならループ開始点
    if seen[v] != -1
      @n = path.size
      @m = seen[v]
      return
    end

    # 訪問順と経路に追加
    seen[v] = i
    path << v

    g[v].each do |nv|
      dfs(nv, i + 1)
    end
  end
end
