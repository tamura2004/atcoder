require "crystal/graph/i_graph"
require "crystal/i_segment_tree"

# 根付木のHL分解
#
# ```
# ```
class HLDecomposition
  getter g : IGraph
  delegate n, to: g

  getter root : Int32
  getter id : Int32
  getter enter : Array(Int32)
  getter leave : Array(Int32)
  getter par : Array(Int32)
  getter head : Array(Int32)
  getter sub : Array(Int32)

  def initialize(@g, @root = 0)
    @id = 0
    @enter = Array.new(n, -1)
    @leave = Array.new(n, -1)
    @par = Array.new(n, -1)
    @head = Array.new(n, -1)
    @sub = Array.new(n, -1)

    # 部分木の大きさを別途求める
    dfs_sub(root, -1)

    # 訪問順、親、ヘビーパスの先頭を求める
    dfs(root, -1, root)
  end

  # 部分木の大きさを求める
  def dfs_sub(v, pv)
    sub[v] = 1
    g.each(v) do |nv|
      next if nv == pv
      dfs_sub(nv, v)
      sub[v] += sub[nv]
    end
  end

  # 訪問順、親、ヘビーパスの先頭を求める
  def dfs(v, pv, hv)
    enter[v] = id
    @id += 1
    par[v] = pv
    head[v] = hv

    # 親でない隣接頂点を列挙
    vs = [] of Int32
    g.each(v) do |nv|
      next if nv == pv
      vs << nv
    end

    # 部分木の大きい順にソート、先頭がヘビーパス
    vs.sort_by { |i| {-sub[i], i} }.each_with_index do |nv, i|
      case i
      when 0 # heavy path
        dfs(nv, v, hv)
      else
        dfs(nv, v, nv)
      end
    end

    # 離脱順を記録。直前の訪問順と重ねる。
    leave[v] = @id - 1
  end

  # 最小共通祖先
  def lca(v, nv)
    loop do
      swap(v, nv) unless enter[v] < enter[nv]
      return v if head[v] == head[nv]
      nv = par[head[nv]]
    end
  end

  # パス上のクエリ
  def path_query(v, nv, edge = true, &f : (Int32, Int32) -> _)
    edge = edge.to_unsafe

    loop do
      swap(v, nv) unless enter[v] < enter[nv]
      yield Math.max(enter[head[nv]], enter[v] + edge), enter[nv]
      return v if head[v] == head[nv]
      nv = par[head[nv]]
    end
  end

  # パス上のクエリをセグ木に累積
  def path_query_with_st(v, nv, st : ISegmentTree(T), edge = true) forall T
    ans = T.zero
    path_query(v, nv, edge) do |v, nv|
      ans = st.fx.call(ans, st[v..nv])
    end
    ans
  end

  # 部分木のクエリ
  def subtree_query(v, edge = true, &f : (Int32, Int32) -> _)
    edge = edge.to_unsafe
    yield enter[v] + edge, leave[v]
  end

  macro swap(x, y)
    {{x}}, {{y}} = {{y}}, {{x}}
  end
end
