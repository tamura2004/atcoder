require "crystal/graph"
require "crystal/graph/i_graph"

class CentroidDecomposition
  getter g : IGraph
  delegate n, to: g
  getter centroid : Array(Bool)
  getter subtree_size : Array(Int32)

  def initialize(@g)
    @centroid = Array.new(n, false)
    @subtree_size = Array.new(n, 0)
  end

  def solve
    each_centroid(0) do |v|
      pp! v
    end
  end

  def each_centroid(root, &b : Int32 -> _)
    compute_subtree_size(root, -1)
    _, v = search_centroid(root, -1, subtree_size[root])
    centroid[v] = true
    yield v

    g.each(v) do |nv|
      next if centroid[nv]
      each_centroid(nv, &b)
    end
  end

  # vを根とする部分木の大きさを再計算する
  def compute_subtree_size(v, pv)
    cnt = 1
    g.each(v) do |nv|
      next if nv == pv || centroid[nv]
      cnt += compute_subtree_size(nv, v)
    end
    subtree_size[v] = cnt
  end

  # 重心となる頂点を探す再帰関数。tは連携積成分全体の大きさ。
  # v以下で、削除により残る最大の部分木の頂点数が最小となる頂点の、
  # { 残る最大の部分木の頂点数, 頂点番号 }のタプルを返す
  def search_centroid(v, pv, t)
    res = {Int32::MAX, -1}
    s = 1
    m = 0
    g.each(v) do |nv|
      next if nv == pv || centroid[nv]
      cnt = search_centroid(nv, v, t)
      res = cnt if res > cnt
      m = subtree_size[nv] if m < subtree_size[nv]
      s += subtree_size[nv]
    end

    m = Math.max(m, t - s)
    res = {m, v} if res > {m, v}
    res
  end
end

g = Graph.new([-1,1,2,3,4,5,6,7,8,9,10,11,12,13])
cd = CentroidDecomposition.new(g)
cd.solve

