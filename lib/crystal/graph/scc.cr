require "crystal/graph/i_graph"
require "crystal/graph/ord"
require "crystal/graph/reverse_graph_factory"

# 強連結成分分解
#
# ```
# g = Graph.new(6)
# g.add 1,2,both: false
# g.add 2,3,both: false
# g.add 3,1,both: false
# g.add 1,4,both: false
# g.add 4,5,both: false
# g.add 5,6,both: false
# g.add 6,4,both: false
# +--------------+
# |              v
# |  +---+     +---+
# |  | 2 | <-- | 1 |
# |  +---+     +---+
# |    |         |
# |    |         |
# |    v         v
# |  +---+     +---+
# +- | 3 |     | 4 | <+
#    +---+     +---+  |
#                |    |
#                |    |
#                v    |
#              +---+  |
#              | 5 |  |
#              +---+  |
#                |    |
#                |    |
#                v    |
#              +---+  |
#              | 6 | -+
#              +---+
# SCC.new(g).solve.should eq [[0,1,2],[3,4,5]]
# ```
class SCC
  getter g : IGraph
  delegate n, to: g

  getter now_ord : Int32
  getter group_num : Int32

  getter ord : Array(Int32)
  getter low : Array(Int32)
  getter ids : Array(Int32)
  getter visited : Array(Int32)

  def initialize(@g)
    @now_ord = 0
    @group_num = 0

    @ord = Array.new(n, -1)
    @low = Array.new(n, 0)
    @ids = Array.new(n, 0)
    @visited = [] of Int32
  end

  def solve
    g.each do |v|
      next if ord[v] != -1
      dfs(v)
    end
    ids.map!(&.-.pred.+ group_num)

    scc = Array.new(group_num) { [] of Int32 }
    g.each do |v|
      scc[ids[v]] << v
    end
    scc
  end

  def dfs(v)
    low[v] = ord[v] = now_ord
    @now_ord += 1
    visited << v

    g.each(v) do |nv|
      if ord[nv] == -1
        dfs(nv)
        low[v] = low[nv] if low[v] > low[nv]
      else
        low[v] = ord[nv] if low[v] > ord[nv]
      end
    end

    if low[v] == ord[v]
      loop do
        nv = visited.pop
        ord[nv] = n
        ids[nv] = group_num
        break if v == nv
      end

      @group_num += 1
    end
  end
end
