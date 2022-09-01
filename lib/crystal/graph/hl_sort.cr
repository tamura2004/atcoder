require "crystal/graph/subtree_size"

# HL分解で使用
# 各隣接リストにおいて、先頭にHeavyPathが来るように自身を並べ替える
#
# ```
# g = Tree.new(4)
# g.add 1, 2, both: false
# g.add 1, 3, both: false
# g.add 3, 4, both: false
# g.g.should eq [[1, 2], [] of Int32, [3], [] of Int32]
# HLSort.new(g).sort!
# g.g.should eq [[2, 1], [] of Int32, [3], [] of Int32]
# ```
class HLSort
  getter g : IGraph
  delegate n, to: g

  def initialize(@g)
  end

  def solve(root = 0)
    ss = SubtreeSize.new(g).solve(root)

    g.each do |v|
      g.each(v) do |nv|
      g[v].sort_by! do |nv|
        -ss[nv]
      end
    end
  end

  def sort!(root = 0)
    solve(root)
  end
end
