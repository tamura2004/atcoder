require "crystal/graph/i_graph"

# 橋と関節点を求める
#
# ord: グラフをdfsして訪れた順番
# low: 葉方向の辺を0回以上、後退辺を1回以下通って到達可能な点のordの最小値
# bridge: 橋（除去すると非連結になる辺）
# articulation: 関節点（除去すると非連結になる頂点）
#
# ```
# g = Graph.new(6)
# g.add 1, 2
# g.add 3, 2
# g.add 1, 3
# g.add 1, 4
# g.add 4, 5
# g.add 6, 5
# g.add 4, 6
# +--------------+
# |              |
# |  +---+     +---+
# |  | 2 | --- | 1 |
# |  +---+     +---+
# |    |         |
# |    |         |
# |    |         |
# |  +---+     +---+
# +- | 3 |     | 4 | -+
#    +---+     +---+  |
#                |    |
#                |    |
#                |    |
#              +---+  |
#              | 5 |  |
#              +---+  |
#                |    |
#                |    |
#                |    |
#              +---+  |
#              | 6 | -+
#              +---+
# bridge, articulation, ord, low = LowLink.new(g).solve
# bridge.should eq [{0, 3}]
# articulation.should eq [3, 0]
# ord.should eq [0, 1, 2, 3, 4, 5]
# low.should eq [0, 0, 0, 3, 3, 3]
# ```
class LowLink
  getter g : IGraph
  delegate n, to: g
  getter ord : Array(Int32)
  getter low : Array(Int32)
  getter id : Int32
  getter articulation : Array(Int32)
  getter bridge : Array(Tuple(Int32,Int32))

  def initialize(@g)
    @ord = Array.new(n, -1)
    @low = Array.new(n, -1)
    @id = 0
    @articulation = [] of Int32
    @bridge = [] of Tuple(Int32,Int32)
  end

  def solve
    g.each do |v|
      next if ord[v] != -1
      ord[v] = 0
      dfs(v, -1)
    end

    {bridge, articulation, ord, low}
  end

  def dfs(v, pv)
    ord[v] = low[v] = @id
    @id += 1

    is_articulation = false
    cnt = 0

    g.each(v) do |nv|
      next if nv == pv
      if ord[nv] != -1
        low[v] = Math.min low[v], ord[nv]
      else
        cnt += 1
        dfs(nv, v)
        low[v] = Math.min low[v], low[nv]
        is_articulation ||= pv != -1 && ord[v] <= low[nv]
        bridge << {v, nv} if ord[v] < low[nv]
      end
    end

    is_articulation ||= pv == -1 && cnt > 1
    articulation << v if is_articulation
  end
end
