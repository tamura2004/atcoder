require "crystal/graph"

# 最短距離を求める
class Depth
  getter g : Graph
  delegate n, to: g
  getter depth : Array(Int32)

  def initialize(@g)
    @depth = Array.new(n, -1)
  end

  def solve(root = 0)
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
