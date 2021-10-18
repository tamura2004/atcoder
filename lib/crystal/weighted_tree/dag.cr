require "crystal/weighted_tree/tree"

# 根に向かう辺を取り除きDAGにする
module WeightedTree
  class Dag
    getter g : Tree
    getter ng : Tree
    delegate n, to: g

    def initialize(@g)
      @ng = Tree.new(n)
    end

    def solve(root = 0)
      dfs(root, -1)
      ng
    end

    def dfs(v, pv)
      g[v].each do |nv, cost|
        next if nv == pv
        ng.add v, nv, cost, origin: 0, both: false
        dfs(nv, v)
      end
    end
  end
end
