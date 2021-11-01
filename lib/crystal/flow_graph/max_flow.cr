require "crystal/flow_graph/graph"

module FlowGraph
  struct MaxFlow
    getter g : Graph
    delegate n, to: g
    getter depth : Array(Int32)
    getter visit : Array(Int32)

    def initialize(@g)
      @depth = Array.new(n, -1)
      @visit = Array.new(n, 0)
    end

    def solve(start = 0, target = n - 1) : Cap
      flow = 0_i64

      loop do
        bfs(start)
        return flow if depth[target] < 0
        visit.fill(0)

        while (flowed = dfs(start, target, Cap::MAX)) > 0
          flow += flowed
        end
      end
    end

    def bfs(start)
      depth.fill(-1)
      depth[start] = 0
      q = Deque.new([start])

      while q.size > 0
        v = q.shift

        g[v].each do |nv, rev, cap|
          next if depth[nv] != -1
          next if cap <= 0
          depth[nv] = depth[v] + 1
          q << nv
        end
      end
    end

    def dfs(v, target, flow) : Cap
      return flow if v == target
      edges = g[v]

      while visit[v] < edges.size
        i = visit[v]
        nv, rev, cap = edges[i]

        if cap > 0 && depth[v] < depth[nv]
          flowed = dfs(nv, target, Math.min(flow, cap))

          if flowed > 0
            edges[i] = add_cap(edges[i], -flowed)
            g[nv][rev] = add_cap(g[nv][rev], flowed)
            return flowed
          end
        end

        visit[v] += 1
      end

      0_i64
    end
  end
end
