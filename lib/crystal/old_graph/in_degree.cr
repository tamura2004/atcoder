require "crystal/graph"

# グラフの頂点毎の入次数を求める
#
# ```
# g = Graph.new(3)
# g.add 1, 2, both: false
# g.add 3, 2, both: false
# InDegree.new(g).solve.should eq [0, 2, 0]
# ```
struct InDegree
  getter g : Graph
  delegate n, to: g

  def initialize(@g)
  end

  def solve
    ans = Array.new(n, 0)
    n.times do |v|
      g[v].each do |nv|
        ans[nv] += 1
      end
    end
    ans
  end
end

