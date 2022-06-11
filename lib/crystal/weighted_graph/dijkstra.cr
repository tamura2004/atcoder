require "crystal/priority_queue"
require "crystal/weighted_graph/graph"

module WeightedGraph
  # ダイクストラ法により単一始点最短経路を求める
  #
  # 頂点を`V`、辺を`E`、コストを`Cost`として持つ
  # 有向グラフを対象とする。
  #
  # [1] -2-> [2]
  #  | \      |
  #  7   3    2
  #  |     \  |
  #  V      v V
  # [4] <-2- [3]
  # ```
  # g = Graph.new(4)
  # g.add 1, 2, 2
  # g.add 2, 3, 2
  # g.add 1, 3, 3
  # g.add 3, 4, 2
  # g.add 1, 4, 7
  # Dijkstra.new(g).solve.should eq [0, 2, 3, 5]
  # ```
  struct Dijkstra
    INF = Cost::MAX//4
    getter g : Graph
    getter seen : Array(Bool)
    getter depth : Array(Cost)
    delegate n, to: g

    def initialize(@g)
      @seen = Array.new(n, false)
      @depth = Array.new(n, INF)
    end

    # ダイクストラ法により*root*始点の最短経路を求める
    #
    # 始点のパラメータ*root*は0-indexed
    # 結果はコストの配列(`Array(Cost)`)
    def solve(root = 0) : Array(Cost)
      seen.fill(false)

      depth.fill(INF)
      depth[root] = 0_i64

      q = PriorityQueue(Tuple(Cost,V)).lesser
      q << {0_i64, root}

      while q.size > 0
        cost, v = q.pop
        next if seen[v]
        seen[v] = true
        depth[v] = cost

        g[v].each do |nv, ncost|
          next if seen[nv]
          q << {cost + ncost, nv}
        end
      end

      depth
    end
  end
end

alias Dijkstra = WeightedGraph::Dijkstra
INF = WeightedGraph::Dijkstra::INF