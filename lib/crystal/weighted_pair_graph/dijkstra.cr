require "crystal/priority_queue"
require "crystal/weighted_pair_graph/graph"

# 拡張ダイクストラ
module WeightedPairGraph
  struct Dijkstra
    getter g : Graph
    getter seen : Hash(V,Bool)
    getter depth : Hash(V, Cost)

    def initialize(@g)
      @seen = Hash(V,Bool).new
      @depth = Hash(V, Cost).new
    end

    def solve(root : V)
      seen.clear

      depth.clear
      depth[root] = 0

      q = PriorityQueue(Tuple(Cost, V)).lesser
      q << {0_i64, root}

      while q.size > 0
        cost, v = q.pop
        next if seen[v]?
        seen[v] = true
        depth[v] = cost

        g[v].each do |nv, ncost|
          next if seen[nv]?
          q << {cost + ncost, nv}
        end
      end

      depth
    end
  end
end