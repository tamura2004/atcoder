require "crystal/priority_queue"
require "crystal/graph/i_graph"

# ダイクストラ法により、正の重み付きグラフの
# 一点開始、全点への最短距離を求める
class Dijkstra
  INF = Int64::MAX // 4

  getter g : IGraph
  delegate n, to: g

  def initialize(@g)
  end

  def solve(root = 0)
    q = [{0_i64, root.to_i}].to_pq_lesser
    seen = Array.new(n, false)
    depth = Array.new(n, INF)

    while q.size > 0
      cost, v = q.pop
      next if seen[v]
      seen[v] = true
      depth[v] = cost

      g.each_with_cost(v) do |nv, ncost|
        next if seen[nv]
        q << {cost + ncost, nv}
      end
    end

    depth
  end
end
