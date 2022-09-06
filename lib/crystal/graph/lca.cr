require "crystal/graph/i_graph"
require "crystal/graph/depth"
require "crystal/graph/parent"

# 根付き木の最小共通祖先を求める
class Lca
  getter g : IGraph
  delegate n, to: g

  getter root : Int32
  getter depth : Array(Int64)
  getter pa : Parent

  def initialize(@g, @root)
    g.tree!

    @depth = Depth.new(g).solve(root)
    @pa = Parent.new(g, root)
  end

  def solve(v, nv)
    # 深いほうをnvにする
    v, nv = nv, v unless depth[v] <= depth[nv]

    # 深さをそろえる
    nv = pa.up(nv, depth[nv] - depth[v])

    # 既に一致しているならそれが答え
    return v if v == nv

    # 二分探索
    # 2^40上、2^39上を降り順に調べ、不一致なら上る
    (0...Parent::D).reverse_each do |i|
      pv = pa[i][v.not_nil!]
      pnv = pa[i][nv.not_nil!]

      if pv != pnv
        v = pv
        nv = pnv
      end
    end

    # 親がLCA
    pa[0][v.not_nil!]
  end

  # vとnvのパスの長さを求める
  def len(v, nv)
    path_query(v, nv, depth)
  end
  
  # st[v]が根から頂点までのコストを返すとき
  # v〜nvパスのコストを返す
  def path_query(v, nv, st)
    t = solve(v, nv).not_nil!
    st[enter[v]] + st[enter[nv]] - st[t] * 2
  end
end
