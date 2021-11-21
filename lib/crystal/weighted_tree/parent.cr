require "crystal/weighted_tree/tree"

module WeightedTree
  # 親の頂点とコストを求める
  #
  # Example:
  # ```
  # g = Tree.new(5)
  # g.add 1, 2, 10
  # g.add 1, 3, 20
  # g.add 2, 4, 30
  # g.add 2, 5, 40
  # g.debug # =>
  # +---+     +---+
  # | 3 | --- | 1 |
  # +---+     +---+
  #             |
  #             |
  #             |
  # +---+     +---+
  # | 5 | --- | 2 |
  # +---+     +---+
  #             |
  #             |
  #             |
  #           +---+
  #           | 4 |
  #           +---+
  # Parent.new(g).solve # => [{-1,-1}, {0,10}, {0,20}, {1,30}, {1,40}]
  # ```
  struct Parent
    getter g : Tree
    delegate n, to: g

    getter parent : Array(Tuple(Int32, Int64))

    def initialize(@g)
      @parent = Array.new(n) do
        {-1, -1_i64}
      end
    end

    def solve(root = 0)
      dfs(root, -1, -1_i64)
      parent
    end

    def dfs(v, pv, pcost)
      parent[v] = {pv, pcost}

      g[v].each do |nv, cost|
        next if nv == pv
        dfs(nv, v, cost)
      end
    end
  end
end
