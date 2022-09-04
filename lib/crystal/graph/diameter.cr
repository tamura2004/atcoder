require "crystal/graph/i_graph"

# 木の直径を求め両端の頂点を返す
# ```
# g = Graph.new(5)
# g.add 1, 2, 10
# g.add 2, 3, 20
# g.add 2, 4, 30
# g.add 1, 5, 50
# Diameter.new(g).solve.should eq {4, 3}
# ```
class Diameter
  getter g : IGraph
  delegate n, to: g

  def initialize(@g)
    @g.tree!
  end

  def deepest_point(root = 0)
    dfs(root, -1, 0_i64)
  end

  def dfs(v, pv, depth)
    ans = {depth, v}
    g.each_with_cost(v) do |nv, cost|
      next if nv == pv
      cnt = dfs(nv, v, depth + cost)
      ans = cnt if ans < cnt
    end
    ans
  end

  def solve
    # 任意の一つの点の最遠点aを求める
    a_depth, a = deepest_point

    # aの最遠点bを求める。パスa-bが直径
    b_depth, b = deepest_point(a)

    {a, b}
  end
end
