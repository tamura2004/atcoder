require "crystal/graph/i_graph"
require "crystal/modint9"

# 木の同型判定に使用するハッシュ値
class TreesHash
  getter g : IGraph
  delegate n, to: g
  getter r : Array(ModInt)
  
  def initialize(@g)
    g.tree!
    @r = Array.new(n,&.hash.//(2).to_m)
  end

  def solve(root = 0)
    dfs(root, -1, 0)
  end

  def dfs(v, pv, depth)
    ret = 1.to_m
    g.each(v) do |nv|
      next if nv == pv
      ret *= dfs(nv, v, depth + 1) + r[depth]
    end
    ret
  end
end
