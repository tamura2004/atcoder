require "crystal/graph/i_graph"
require "crystal/modint9"

class TreesHash
  getter g : IGraph
  delegate n, to: g
  
  def initialize(@g)
    g.tree!
  end

  def solve(root = 0)
    dfs(root, -1, 0)
  end

  def dfs(v, pv, depth)
    ret = 1.to_m
    g.each do |nv|
      next if nv == pv
      ret *= dfs(nv, v, depth + 1) + depth.hash
    end
    ret
  end
end
