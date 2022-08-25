require "crystal/graph/i_graph"

class Depth
  getter g : IGraph
  delegate n, to: g

  def initialize(@g)
  end

  def solve(root = 0)
    depth = Array.new(n, -1)
    depth[0] = 0
    q = Deque.new([root])

    while q.size > 0
      v = q.shift
      g.each(v) do |nv|
        next if depth[nv] != -1
        depth[nv] = depth[v] + 1
        q << nv
      end
    end

    depth
  end
end
