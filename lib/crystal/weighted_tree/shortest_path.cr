require "crystal/weighted_tree/lca"

module WeightedTree
  # LCAを利用して頂点間のパスを求める
  class ShortestPath
    getter g : Tree
    getter parent : Array(Tuple(Int32,Int64))
    getter lca : Proc(Int32, Int32, Int32)

    def initialize(@g)
      @parent = Parent.new(g).solve
      @lca = Lca.new(g).solve
    end

    def solve(u, v)
      pv = lca.call(u, v)

      left = [] of Tuple(Int32,Int64)
      while u != pv
        left << u
        u = parent[u]
      end

      right = [] of Tuple(Int32,Int64)
      while v != pv
        right << v
        v = parent[v]
      end

      left + right.reverse
    end
  end
end
