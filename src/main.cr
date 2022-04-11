# 全てのｋについて、c_k開始の最短距離を
# 幅優先検索で求める
# c_iの重み付きグラフを作る
# TSPを解く
# 距離＋１が答え

require "crystal/graph"

class BFS
  getter g : Graph
  delegate n, to: g

  def initialize(@g)
  end

  def solve(root = 0)
    q = Deque.new([root])
    seen = Hash(Int32,Bool).new(false)
    seen[root] = true
    dist = Array.new(n, 0)

    while q.size > 0
      v = q.shift
      g[v].each do |nv|
        next if seen[nv]
        seen[nv] = true
        dist[nv] = dist[v] + 1
        q << nv
      end
    end
    dist
  end
end

g = Graph.new(5)
g.add 1, 2
g.add 3, 2
g.add 2, 4
g.add 1, 5

pp BFS.new(g).solve(0)
pp BFS.new(g).solve(4)