require "crystal/priority_queue"
require "crystal/list_graph"

# ダイクストラ法により単一始点最短経路を求める
#
# 頂点を`Vertex`、辺を`Edge`、コストを`Cost`として持つ
# 有向グラフを対象とする。
#
# [1] -2-> [2]
#  | \      |
#  7   3    2
#  |     \  |
#  V      v V
# [4] <-2- [3]
# ```
# g = Dijkstra.new(4)
# g.add_edge 1,2,2
# g.add_edge 2,3,2
# g.add_edge 1,3,3
# g.add_edge 3,4,2
# g.add_edge 1,4,7
# g.solve(0) # => [0,2,3,5]
# ```
class Dijkstra < ListGraph

  # ダイクストラ法により*init*始点の最短経路を求める
  #
  # 始点のパラメータ*init*は0-indexed
  # 結果はコストの配列(`Array(Cost)`)
  def solve(init : V) : Array(C)
    q = PriorityQueue(E).new { |a, b| a.last > b.last }
    q << {init, 0_i64}

    seen = Array.new(n, false)
    costs = Array.new(n, INF)

    while q.size > 0
      v, cost = q.pop
      next if seen[v]
      seen[v] = true
      costs[v] = cost
      g[v].each do |nv, ncost|
        next if seen[nv]
        q << {nv, cost + ncost}
      end
    end
    return costs
  end
end

