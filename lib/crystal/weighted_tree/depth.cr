require "crystal/weighted_tree/tree"

module WeightedTree
  class Depth
    getter g : Tree
    delegate n, to: g
    getter depth : Array(Int64)

    def initialize(@g)
      @depth = Array.new(n, 0_i64)
    end

    def solve(root = 0)
      dfs(root, -1)
      depth
    end

    def dfs(v, pv)
      g[v].each do |nv, cost|
        next if nv == pv
        depth[nv] = depth[v] + cost
        dfs(nv, v)
      end
    end
  end
end
