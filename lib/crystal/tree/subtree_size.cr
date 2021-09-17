require "crystal/tree"

# 部分木の大きさを求める
struct SubtreeSize
  getter g : Tree
  getter subtree : Array(Int32)
  delegate n, to: g

  def initialize(@g)
    @subtree = Array.new(n, -1)
  end

  def solve(root = 0)
    dfs(0, -1)
    subtree
  end

  def dfs(v, pv)
    subtree[v] = 1

    g[v].each do |nv|
      next if nv == pv
      subtree[v] += dfs(nv, v)
    end

    subtree[v]
  end
end
