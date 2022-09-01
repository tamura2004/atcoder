require "crystal/graph/i_graph"

# 部分木の大きさを求める
#
# ```
# g = Tree.new(6)
# g.add 1, 2
# g.add 1, 3
# g.add 2, 4
# g.add 2, 5
# g.add 3, 6
# SubtreeSize.new(g).solve.should eq [6, 3, 2, 1, 1, 1]
# ```
struct SubtreeSize
  getter g : IGraph
  getter ans : Array(Int32)
  delegate n, to: g

  def initialize(@g)
    @g.tree!
    @ans = Array.new(n, 0)
  end

  def solve(root = 0)
    dfs(root, -1)
    ans
  end

  def dfs(v, pv)
    ans[v] = 1

    g.each(v) do |nv|
      next if nv == pv
      dfs(nv, v)
      ans[v] += ans[nv]
    end
  end
end
