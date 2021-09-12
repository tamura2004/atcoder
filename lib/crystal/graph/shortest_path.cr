require "crystal/graph"

# グラフの最短経路を一つ検出する
# *start* : 開始点
# *goal* : 終了点
#
# Example:
# ```
# # 頂点1からnまでの最短路のパスを求める
# g = Graph.new(6)
# g.add 1, 2
# g.add 2, 3
# g.add 2, 4
# g.add 4, 5
# g.add 3, 6
# g.add 5, 6
# ShortestPath.new(g).solve # => [0, 1, 2, 5]
#
# 最短路が無い（連結でない）場合はnilを返す
# g = Graph.new(6)
# g.add 1, 2
# g.add 2, 3
# g.add 2, 4
# g.add 4, 3
# g.add 3, 1
# g.add 5, 6
# ShortestPath.new(g).solve # => nil
# ```
struct ShortestPath
  getter n : Int32
  getter g : Graph
  getter depth : Array(Int32)
  getter par : Array(Int32)

  def initialize(@g)
    @n = g.n
    @depth = Array.new(n, -1)
    @par = Array.new(n, -1)
  end

  def solve(start = 0, goal = n - 1)
    bfs(start)

    return nil if depth[goal] == -1

    # 経路復元
    path = [] of Int32
    v = goal
    while v != -1
      path << v
      v = par[v]
    end
    path.reverse
  end

  def bfs(root)
    depth[root] = 0
    g.bfs(root) do |v, nv|
      depth[nv] = depth[v] + 1
      par[nv] = v
    end
  end
end
