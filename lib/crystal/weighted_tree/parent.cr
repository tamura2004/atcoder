require "crystal/weighted_tree/tree"

module WeightedTree
  # 親の頂点を求める
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
  # Parent.new(g).solve # => [-1, 0, 0, 1, 1]
  # ```
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

      g[v].each do |nv, cost|
        next if nv == pv
        dfs(nv, v)
      end
    end
  end
end
