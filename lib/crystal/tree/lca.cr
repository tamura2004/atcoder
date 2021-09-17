require "crystal/tree"
require "crystal/tree/depth"
require "crystal/tree/parent"
require "crystal/tree/euler_tour"
require "crystal/segment_tree"

# 最小共通祖先を与えるProcオブジェクトを求める
#
# Example:
# ```
# g = Tree.new(5)
# g.add 1, 3
# g.add 1, 4
# g.add 4, 2
# g.add 4, 5
# g.debug # =>
# +---+     +---+
# | 3 | --- | 1 |
# +---+     +---+
#             |
#             |
#             |
# +---+     +---+
# | 2 | --- | 4 |
# +---+     +---+
#             |
#             |
#             |
#           +---+
#           | 5 |
#           +---+
# lca = Lca.new(g).solve
# lca.call(5, 3) # => 1
# lca.call(5, 2) # => 4
# ```
class Lca
  getter g : Tree
  delegate n, to: g

  def initialize(@g)
  end

  def solve(root = 0, origin = 1)
    depth = Depth.new(g).solve(root)
    parent = Parent.new(g).solve(root)
    enter, leave, index = EulerTour.new(g).solve(root)

    val = index.map do |i|
      i >= 0 ? {depth[i], i} : {depth[parent[~i]], parent[~i]}
    end

    st = SegmentTree.range_min_query(values: val, unit: {Int32::MAX, Int32::MAX})

    ->(u : Int32, v : Int32) {
      u -= origin
      v -= origin
      u, v = v, u if enter[u] > enter[v]
      st[enter[u]..enter[v]][1] + origin
    }
  end
end
