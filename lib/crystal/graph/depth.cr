require "crystal/graph/i_graph"

# 根付木について、根から頂点への距離を求める
#
# ```
# g = Graph.new([1, 4, 1, 4, -1, 4])
# +---+
# | 0 |
# +---+
#   |
#   |
#   |
# +---+     +---+
# | 2 | --- | 1 |
# +---+     +---+
#   |
#   |
#   |
# +---+     +---+
# | 3 | --- | 4 |
# +---+     +---+
#   |
#   |
#   |
# +---+
# | 5 |
# +---+
# Depth.new(g).solve(4).should eq [2, 1, 2, 1, 0, 1]
# ```
class Depth
  getter g : IGraph
  delegate n, to: g
  getter depth : Array(Int64)

  def initialize(@g)
    @g.tree!
    @depth = Array.new(n, 0_i64)
  end

  def solve(root = 0)
    q = Deque.new([{root, -1}])

    while q.size > 0
      v, pv = q.shift

      g.each_with_cost(v) do |nv, cost|
        next if nv == pv
        depth[nv] = depth[v] + cost
        q << {nv, v}
      end
    end
    
    depth
  end
end
