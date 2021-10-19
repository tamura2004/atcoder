require "crystal/tree"
require "crystal/weighted_tree/tree"

# 重み付木を通常の木とコストの配列に分解する
module WeightedTree
  struct ToTree
    getter g : Tree
    getter ng : ::Tree
    delegate n, to: g
    getter costs : Array(Int64)

    def initialize(@g)
      @costs = Array.new(n, 0_i64)
      @ng = ::Tree.new(n)
    end

    def solve(root = 0)
      dfs(root, -1)
      {ng, costs}
    end

    def dfs(v, pv)
      g[v].each do |nv, cost|
        next if nv == pv
        ng.add v, nv, origin: 0
        costs[nv] = cost
        dfs(nv, v)
      end
    end
  end
end
