require "crystal/tree"

module Tree
  struct Parent
    getter g : Tree
    delegate n, to: g

    getter parent : Array(Int32)

    def initialize(@g)
      @parent = Array.new(n, -1)
    end

    def solve(root = 0)
      dfs(root, -1)
      parent
    end

    def dfs(v, pv)
      parent[v] = pv

      g[v].each do |nv|
        next if nv == pv
        dfs(nv, v)
      end
    end
  end
end
