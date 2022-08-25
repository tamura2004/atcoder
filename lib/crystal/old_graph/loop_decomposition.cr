require "crystal/graph"

# 有向グラフが複数のループの合成であることが
# 分かっている場合。それぞれのループを返す。
#
# ```
# g = Graph.new(5)
# g.add 4, 2, origin: 0, both: false
# g.add 2, 0, origin: 0, both: false
# g.add 0, 4, origin: 0, both: false
# g.add 3, 1, origin: 0, both: false
# g.add 1, 3, origin: 0, both: false
# ld = LoopDecomposition.new(g)
# ld.solve.should eq [[0,4,2],[1,3]]
# ```
class LoopDecomposition
  getter g : Graph
  delegate n, to: g
  getter seen : Array(Bool)
  getter ans : Array(Array(Int32))

  def initialize(@g)
    @seen = Array.new(n, false)
    @ans = [] of Array(Int32)
  end

  def solve
    n.times do |v|
      next if seen[v]
      ans << [] of Int32
      dfs(v)
    end
    ans
  end

  def dfs(v)
    seen[v] = true
    return if !ans.last.empty? && ans.last.first == v
    ans.last << v
    g[v].each do |nv|
      dfs(nv)
    end
  end
end
