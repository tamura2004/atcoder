require "crystal/graph"

# グラフの橋を列挙する
#
# Example:
# ```
# 橋を列挙する
# g = Graph.new(6)
# g.add 1, 2
# g.add 2, 3
# g.add 3, 4
# g.add 4, 5
# g.add 5, 6
# g.add 6, 3
# Bridge.new(g).solve # => [{1, 2}, {0, 1}]
#
# 橋がないなら、空配列を返す
# g = Graph.new(6)
# g.add 1, 2
# g.add 2, 3
# g.add 3, 4
# g.add 4, 5
# g.add 5, 6
# g.add 6, 1
# Bridge.new(g).solve # => [] of Tuple(Int32, Int32)
# ```
struct Bridge
  getter n : Int32
  getter g : Graph
  getter seen : Array(Bool)
  getter ord : Array(Int32)
  getter low : Array(Int32)
  getter bridges : Array(Tuple(Int32, Int32))

  def initialize(@g)
    @n = g.n
    @seen = Array.new(n, false)
    @ord = Array.new(n, -1)
    @low = Array.new(n, -1)
    @bridges = [] of Tuple(Int32, Int32)
  end

  def solve
    n.times do |v|
      next if seen[v]
      dfs(v, 0, -1)
    end

    bridges
  end

  def dfs(v, ix, pv)
    seen[v] = true
    ord[v] = low[v] = ix

    g[v].each do |nv|
      next if nv == pv
      if seen[nv]
        low[v] = Math.min low[v], ord[nv]
      else
        dfs(nv, ix + 1, v)
        low[v] = Math.min low[v], low[nv]
        bridges << {v, nv} if ord[v] < low[nv]
      end
    end
  end
end
