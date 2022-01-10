require "crystal/matrix_graph/graph"

module MatrixGraph
  class Connect
    getter g : Graph
    delegate n, to: g
    getter seen : Array(Bool)

    def initialize(@g)
      @seen = Array.new(n, false)
    end

    def solve(u,v)
      seen[u] = true
      dfs(u,v)
    end

    def dfs(u,v)
      return true if u == v

      n.times do |nv|
        next if seen[nv]
        seen[nv] = true

        next if g[u][nv] == INF
        ans = dfs(nv,v)
        return ans if ans
      end
      return false
    end
  end
end
