require "crystal/graph/i_graph"

# 2部グラフ判定
#
# 2部グラフでなければfalse
# 2部グラフであれば、二色の色の塗分け方を返す
#
# Example:
# ```
# g = Graph.new(3)
# g.add 1, 2
# g.add 2, 3
# g.add 3, 1
# Bipartite.new(g).solve # => nil
#
# g = Graph.new(4)
# g.add 1, 2
# g.add 2, 3
# g.add 3, 4
# Bipartite.new(g).solve # => [0, 1, 0, 1]
# ```
struct Bipartite
  BLACK = 0
  WHITE = 1

  getter n : Int32
  getter g : IGraph
  getter color : Array(Int32)

  def initialize(@g)
    @n = g.n
    @color = Array.new(n, -1)
  end

  def solve : Array(Int32) | Nil
    g.each do |root|
      next true if color[root] != -1
      dfs(root, BLACK) || return nil
    end
    color
  end

  def dfs(v, c)
    color[v] = c
    ret = true
    g.each(v) do |nv|
      next if color[nv] == -1 ? dfs(nv, 1 - c) : color[nv] != color[v]
      ret = false
    end
    ret
  end
end
