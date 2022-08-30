require "crystal/graph/i_graph"
require "crystal/graph/dijkstra"
require "crystal/graph/parent"

# 木の直径を求めパスを返す
# ```
# g = Graph.new(5)
# g.add 1, 2, 10
# g.add 2, 3, 20
# g.add 2, 4, 30
# g.add 1, 5, 50
# Diameter.new(g).solve.should eq [3,1,0,4]
# ```
class Diameter
  getter g : IGraph
  delegate n, to: g

  def initialize(@g)
    @g.tree!
  end

  def solve
    # 任意の一つの点の最遠点aを求める
    depth_one = Dijkstra.new(g).solve(0)
    a = n.times.max_by do |v|
      depth_one[v]
    end

    # aの最遠点bを求める。パスa-bが直径
    depth_two = Dijkstra.new(g).solve(a)
    b = n.times.max_by do |v|
      depth_two[v]
    end

    # bを根とした親の一覧を作る
    parent = Parent.new(g).solve(b)

    # 復元
    ans = [a]
    while ans[-1] != b
      ans << parent[ans[-1]]
    end
    ans.reverse
  end
end
