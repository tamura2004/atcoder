require "crystal/tree"

# 頂点番号をDFSの訪問順(in-order)に振りなおす。
#
# gg  : 新しいグラフ
# ord : 古い頂点->新しい頂点
# vid : 新しい頂点->古い頂点
# pa  : 新しい頂点で親の番号、根の親は-1
#
# ```
# g = Tree.new(4)
# g.add 4, 3, both: false
# g.add 4, 1, both: false
# g.add 1, 2, both: false
# gg, ord, vid, pa = InOrderTree.new(g).solve(4 - 1)
# ord.should eq [3, 2, 0, 1]
# vid.should eq [2, 3, 1, 0]
# pa.should eq [-1, 0, 0, 2]
# ```
class InOrderTree
  getter g : Tree
  getter ord : Array(Int32)
  getter pa : Array(Int32)
  delegate n, to: g

  def initialize(@g)
    @ord = [] of Int32
    @pa = Array.new(n, -1)
  end

  def solve(root = 0)
    dfs(root, -1)
    vid = ord.zip(0..).sort.map(&.last)
    gg = Tree.new(n)

    n.times do |v|
      g[v].each do |nv|
        next if vid[v] > vid[nv]
        gg.add vid[v], vid[nv], origin: 0, both: false
        pa[vid[nv]] = vid[v]
      end
    end

    {gg, ord, vid, pa}
  end

  def dfs(v, pv)
    ord << v
    g[v].each do |nv|
      next if nv == pv
      dfs(nv, v)
    end
  end
end