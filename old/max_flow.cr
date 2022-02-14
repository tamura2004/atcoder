module FlowGraph
  alias V = Int32
  alias RV = Int32
  alias Cap = Int64
  alias E = Tuple(V, RV, Cap)

  class Graph
    getter n : Int32
    getter g : Array(Array(E))
    delegate "[]", to: g

    def initialize(n)
      @n = n.to_i
      @g = Array.new(n) { [] of E }
    end

    def add(v, nv, cap, origin = 1)
      v = V.new(v) - origin
      nv = V.new(nv) - origin
      cap = Cap.new(cap)

      rev_v = g[v].size
      rev_nv = g[nv].size

      g[v] << E.new nv, rev_nv, cap
      g[nv] << E.new v, rev_v, Cap.zero
    end
  end

  struct MaxFlow
    getter g : Graph
    delegate n, add_cap, to: g
    getter depth : Array(Int32)
    getter visit : Array(Int32)

    def initialize(@g)
      @depth = Array.new(n, -1)
      @visit = Array.new(n, 0)
    end

    def flow(start, target) : Cap
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

    @[AlwaysInline]
    def add_cap(e : E, cost : Cap)
      nv, rev, cap = e
      E.new(nv, rev, cap + cost)
    end
  end
end
