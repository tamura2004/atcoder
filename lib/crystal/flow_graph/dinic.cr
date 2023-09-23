require "crystal/flow_graph/graph"

# 最大流
# 最小カット
module FlowGraph
  class Dinic
    getter g : Graph
    getter depth : Array(Int32)
    getter visit : Array(Int32)

    delegate n, to: g

    def initialize(@g)
      @depth = Array.new(n, -1)
      @visit = Array.new(n, 0)
    end

    def solve(root = 0, goal = n - 1, flow_limit = Int64::MAX, trace = false)
      root = root.to_i
      goal = goal.to_i

      flow = 0_i64

      loop do
        bfs(root)
        return flow if flow == flow_limit || depth[goal] < 0
        visit.fill(0)

        while (flowed = dfs(root, goal, flow_limit - flow)) > 0
          flow += flowed

          # trace = onの時、増加路を増やすたびに図示
          if trace
            puts "=" * 40
            g.debug
          end
        end
      end
    end

    def bfs(root)
      depth.fill(-1)
      depth[root] = 0
      q = Deque.new([root])

      while q.size > 0
        v = q.shift

        g[v].each do |e|
          nv, cap = e.v, e.cap

          next if depth[nv] != -1
          next if cap <= 0_i64
          depth[nv] = depth[v] + 1
          q << nv
        end
      end
    end

    def dfs(v, goal, flow)
      return flow if v == goal
      edges = g[v]

      # for (int &i = visit[v]; i < g[v].size(); i++)
      while visit[v] < edges.size
        i = visit[v]
        e = edges[i]
        nv, re, cap = e.v, e.re, e.cap

        if cap > 0 && depth[v] < depth[nv]
          flowed = dfs(nv, goal, Math.min(flow, cap))
          if flowed > 0
            edges[i].cap -= flowed
            g[nv][re].cap += flowed
            return flowed
          end
        end
        visit[v] += 1
      end
      0_i64
    end
  end
end

alias Dinic = FlowGraph::Dinic
INF = Int64::MAX
