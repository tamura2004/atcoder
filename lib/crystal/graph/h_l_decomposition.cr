require "crystal/graph/i_graph"

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
  getter par : Array(Int32)
  getter head : Array(Int32)
  getter sub : Array(Int32)

  def initialize(@g, @root = 0)
    @id = 0
    @enter = Array.new(n, -1)
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
    vs.sort_by { |i| -sub[i] }.each_with_index do |nv, i|
      case i
      when 0 # heavy path
        dfs(nv, v, hv)
      else
        dfs(nv, v, nv)
      end
    end
  end

  def lca(v, nv)
    if head[v] == head[nv]
      enter[v] < enter[nv] ? v : nv
    else
      if enter[v] < enter[nv]
        lca(v, par[head[nv]])
      else
        lca(par[head[v]], nv)
      end
    end
  end
end
