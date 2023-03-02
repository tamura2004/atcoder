require "crystal/graph"

# 木の重心分解
class CentroidDecomposition
  getter g : IGraph
  delegate n, to: g
  getter enter : Array(Int32) # 重心の訪問順
  getter sub : Array(Int64)   # 部分木の大きさ
  getter id : Int32           #
  getter ans : Int64
  getter centroid_tree : Graph
  getter centroid_root : Int32

  def initialize(@g)
    g.tree!
    @enter = Array.new(n, -1)
    @id = 0
    @sub = Array.new(n, 0_i64)
    @ans = 0_i64
    @centroid_root = -1
    @centroid_tree = Graph.new(n)
  end

  def build!
    dfs(0)
  end

  def dfs(v)
    update_subtree_size(v, -1)
    _, centroid_vertex = centroid(v, -1, sub[v])
    @centroid_root = centroid_vertex if @centroid_root == -1
    enter[centroid_vertex] = id
    @id += 1

    each(centroid_vertex) do |nv|
      next_centroid_vertex = dfs(nv)
      centroid_tree.add centroid_vertex, next_centroid_vertex, origin: 0, both: false
    end

    centroid_vertex
  end

  # vを根とする部分木の大きさを再計算する
  def update_subtree_size(v, pv)
    cnt = 1_i64
    each(v) do |nv|
      next if nv == pv
      cnt += update_subtree_size(nv, v)
    end
    sub[v] = cnt
  end

  # メモリに配慮した深さ別集計
  def depth(root)
    acc = [1]
    dfs_depth(acc, 1, root, -1)
    acc
  end

  def dfs_depth(acc, dep, v, pv)
    each(v) do |nv|
      next if nv == pv
      if acc.size <= dep
        acc << 1
      else
        acc[dep] += 1
      end
      dfs_depth(acc, dep + 1, nv, v)
    end
  end

  # 重心となる頂点を探す再帰関数。totは連結成分全体の大きさ。
  # v以下で、削除により残る最大の部分木の頂点数が最小となる頂点の、
  # {残る最大の部分木のサイズ, 重心の頂点番号}のタプルを返す
  def centroid(v, pv, tot)
    ans = {Int32::MAX, -1}
    size = 1 # 自身を根とする部分木のサイズ
    max = 0  # 子部分木の最大サイズ

    each(v) do |nv|
      next if nv == pv
      cnt = centroid(nv, v, tot)
      chmin ans, cnt
      chmax max, sub[nv]
      size += sub[nv]
    end

    chmax max, tot - size # tot - sizeは親方向の部分木のサイズ
    chmin ans, {max, v}
    ans
  end

  # 削除済を除く隣接頂点の列挙
  def each(v)
    g.each(v) do |nv|
      next if enter[nv] != -1
      yield nv
    end
  end

  macro chmax(target, other)
    {{target}} = ({{other}}) if ({{target}}) < ({{other}})
  end

  macro chmin(target, other)
    {{target}} = ({{other}}) if ({{target}}) > ({{other}})
  end
end

