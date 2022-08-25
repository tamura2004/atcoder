require "crystal/graph"

# 一点から開始した各点への最短距離を求める
#
# ```
# g = Graph.new(4)
# g.add 1, 2
# g.add 1, 4
# g.add 4, 3
# Depth.new(g).solve.should eq [0, 1, 2, 1]
# ```
class Depth
  getter g : Graph
  delegate n, to: g
  getter depth : Array(Int32)

  def initialize(@g)
    @depth = Array.new(n, -1)
  end

  def solve(root = 0)
    depth.fill(-1)
    depth[root] = 0
    q = Deque.new([root])

    while q.size > 0
      v = q.shift
      g[v].each do |nv|
        next if depth[nv] != -1
        depth[nv] = depth[v] + 1
        q << nv
      end
    end

    depth
  end
end
