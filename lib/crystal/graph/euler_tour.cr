require "crystal/graph/i_graph"

# オイラーツアー
#
# enter : 入順
# leave : 出順
# index : 訪問順（入：v, 出:~v）
#
# 木を
# +---+     +---+
# | 3 | --- | 1 |
# +---+     +---+
#             |
#             |
#             |
# +---+     +---+
# | 5 | --- | 2 |
# +---+     +---+
#             |
#             |
#             |
#           +---+
#           | 4 |
#           +---+
# 列に
# 1 -> 3 -> ~3 -> 2 -> 5 -> ~5 -> 4 -> ~4 -> ~2 -> ~1
#
# 根から遠い <=> 入順が遅い
#
# ```
# g = Tree.new(5)
# g.add 1, 2
# g.add 1, 3
# g.add 2, 4
# g.add 2, 5
# enter, leave, events = EulerTour.new(g).solve
# enter.should eq [0, 1, 7, 2, 4]
# leave.should eq [9, 6, 8, 3, 5]
# ```
class EulerTour
  enum Event
    Enter
    Leave
  end

  getter g : IGraph
  delegate n, to: g

  getter enter : Array(Int32)
  getter leave : Array(Int32)
  getter events : Array(Tuple(Int32, Event))

  def initialize(@g, root = 0)
    @g.tree!
    @enter = Array.new(n, -1)
    @leave = Array.new(n, -1)
    @events = [] of Tuple(Int32,Event)

    dfs(root, -1)
  end

  def solve
    {enter, leave, events}
  end

  def dfs(v, pv)
    enter[v] = events.size
    events << { v, Event::Enter }

    g.each(v) do |nv|
      next if nv == pv
      dfs(nv, v)
    end

    leave[v] = events.size
    events << { v, Event::Leave }
  end
end
