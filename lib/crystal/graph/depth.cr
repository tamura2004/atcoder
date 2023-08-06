require "crystal/graph/i_graph"

class Depth
  getter g : IGraph
  delegate n, to: g
  getter depth : Array(Int64)

  def initialize(@g)
    @depth = Array.new(n, -1_i64)
  end

  def solve(root = 0)
    depth[root] = 0_i64
    q = Deque.new([root])

    while q.size > 0
      v = q.shift

      g.each_with_cost(v) do |nv, cost|
        next if depth[nv] != -1_i64
        depth[nv] = depth[v] + cost
        q << nv
      end
    end

    depth
  end
end
