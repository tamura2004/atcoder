require "crystal/tree"

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
# enter, leave, index = EulerTour.new(g).solve
# enter.should eq [0, 1, 7, 2, 4]
# leave.should eq [9, 6, 8, 3, 5]
# index.should eq [0, 1, 3, -4, 4, -5, -2, 2, -3, -1]
# ```
class EulerTour
  getter g : Tree
  delegate n, to: g

  getter enter : Array(Int32)
  getter leave : Array(Int32)
  getter index : Array(Int32)

  def initialize(@g)
    @enter = Array.new(n, -1)
    @leave = Array.new(n, -1)
    @index = [] of Int32
  end

  def solve(root = 0)
    dfs(0, -1)
    {enter, leave, index}
  end

  def dfs(v, pv)
    enter[v] = index.size
    index << v

    g[v].each do |nv|
      next if nv == pv
      dfs(nv, v)
    end

    leave[v] = index.size
    index << ~v
  end
end
