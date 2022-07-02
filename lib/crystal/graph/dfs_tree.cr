require "crystal/graph"
require "crystal/tree"

# DFS木を求める
#
# 頂点rootを始点として各頂点に高々1回しか訪れないようDFSを行う
# 使用した辺からなる木をDFS木と呼ぶ。rootを根とした根付き木である。
# 根から葉に向かう有効辺のみ残している。
#
# ```
# g = Graph.new(3)
# g.add 1, 2
# g.add 1, 3
# g.add 2, 3
# DfsTree.new(g).solve(0).g.should eq [[1],[2],[] of Int32] 
# ```
class DFSTree
  getter g : Graph
  getter tree : Tree
  getter seen : Set(Int32)
  delegate n, to: g

  def initialize(@g)
    @seen = Set(Int32).new
    @tree = Tree.new(n)
  end

  def solve(root = 0)
    seen << root
    dfs(root)
    tree
  end

  def dfs(v)
    g[v].each do |nv|
      next if nv.in?(seen)
      seen << nv
      tree[v] << nv
      dfs(nv)
    end
  end
end
