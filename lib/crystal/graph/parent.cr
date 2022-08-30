require "crystal/graph/i_graph"

# 親の頂点を求める
#
# Example:
# ```
# g = Graph.new(5)
# g.add 1, 2
# g.add 1, 3
# g.add 2, 4
# g.add 2, 5
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
class Parent
  getter g : IGraph
  delegate n, to: g

  getter parent : Array(Int32)

  def initialize(@g)
    @g.tree!
    @parent = Array.new(n, -1)
  end

  def solve(root = 0)
    dfs(root, -1)
    parent
  end

  def dfs(v, pv)
    parent[v] = pv

    g.each(v) do |nv|
      next if nv == pv
      dfs(nv, v)
    end
  end
end
