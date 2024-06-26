require "crystal/weighted_flow_graph_with_bellmanford/bellman_ford"

module WeightedFlowGraphWithBellmanford
  struct MinCostFlow
    getter g : Graph
    delegate n, to: g

    def initialize(@g)
    end

    def solve(s, t, f)
      f = f.to_i64
      tot = f
      ans = 0_i64

      while f > 0
        dist, path = BellmanFord.new(g).solve(s)

        if dist[t] == INF
          return nil
        end

        min = path.min_of { |pv, pe| g[pv][pe].cap }
        d = Math.min f, min
        f -= d
        ans += d * dist[t]

        path.each do |pv, pe, v, re|
          g[pv][pe] -= d
          g[v][re] += d
        end
      end

      return {tot - f, ans}
    end
  end
end
