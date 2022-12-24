require "crystal/graph/i_graph"

# 2部グラフ判定
#
# 2部グラフでなければ例外
# 2部グラフであれば、連結成分ごとの二色の色の塗分け方を返す
#
# Example:
# ```
# g = Graph.new(3)
# g.add 1, 2
# g.add 2, 3
# g.add 3, 1
# begin
#  Bipartite.new(g).solve # => nil
# rescue
#  doit!
# end
#
# g = Graph.new(8)
# g.add 1, 2
# g.add 2, 3
# g.add 3, 4
# g.add 1, 4
# g.add 5, 6
# g.add 8, 7
# g.add 6, 7
# g.add 5, 8
# Bipartite.new(g).solve.should eq [0, 1, 0, 1, 2, 3, 2, 3]
# ```
struct Bipartite
  getter g : IGraph
  delegate n, to: g
  getter colors : Array(Int32)

  def initialize(@g)
    @colors = Array.new(n, -1)
  end

  def solve
    color = 0
    g.each do |v|
      next if colors[v] != -1
      dfs(v, color)
      color += 2
    end
    colors
  end

  def dfs(v, color)
    colors[v] = color
    g.each(v) do |nv|
      raise "not a bipartite" if colors[nv] == color
      next if colors[nv] == color ^ 1
      dfs(nv, color ^ 1)
    end
    true
  end
end
