require "crystal/weighted_flow_graph/graph"

module WeightedFlowGraph
  INF = Int64::MAX//2

  struct BellmanFord
    getter g : Graph
    delegate n, to: g
    getter dist : Array(Int64)  # 最短距離
    getter prevv : Array(Int32) # 直前の頂点
    getter preve : Array(Int32) # 直前の辺

    def initialize(@g)
      @dist = Array.new(n, INF)
      @prevv = Array.new(n, -1)
      @preve = Array.new(n, -1)
    end

    def solve(s = 0, t = n - 1)
      dist.fill(INF)
      dist[s] = 0_i64
      update = true

      while update
        update = false

        n.times do |v|
          next if dist[v] == INF

          g[v].each_with_index do |(nv, cap, cost, rev), i|
            if cap > 0 && dist[nv] > dist[v] + cost
              dist[nv] = dist[v] + cost
              prevv[nv] = v
              preve[nv] = i
              update = true
            end
          end
        end
      end

      path = make_reverse_path(s, t)

      {dist, path}
    end

    private def make_reverse_path(s = 0, t = n - 1)
      path = [] of Tuple(Int32, Int32, Int32, Int32)
      v = t
      while v != s
        pv = prevv[v]
        pe = preve[v]
        e = g[pv][pe]
        path << {pv, pe, v, e.rev}
        v = prevv[v]
      end
      path
    end
  end
end
