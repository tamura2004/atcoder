require "crystal/tree"

struct Depth
  getter g : Tree
  delegate n, to: g
  getter depth : Array(Int32)

  def initialize(@g)
    @depth = Array.new(n, 0)
  end

  def solve(root = 0)
    dfs(root, -1)
    depth
  end

  def dfs(v, pv)
    g[v].each do |nv|
      next if nv == pv
      depth[nv] = depth[v] + 1
      dfs(nv, v)
    end
  end
end
