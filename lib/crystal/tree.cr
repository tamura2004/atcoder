require "crystal/segment_tree"

# 木（重みなし）
class Tree
  ENTER = 0
  LEAVE = 1

  getter n : Int32
  getter g : Array(Array(Int32))

  delegate "[]", to: g

  def initialize(n)
    @n = n.to_i
    @g = Array.new(n) { [] of Int32 }
  end

  def initialize(n, &block)
    initialize(n)
    yield self
  end

  def add(v, nv, origin = 1, both = true)
    v = v.to_i - origin
    nv = nv.to_i - origin
    g[v] << nv
    g[nv] << v if both
  end

  # 幅優先検索
  def bfs(root = 0, init : _ = 0)
    seen = [false] * n
    seen[root] = true
    ans = [init] * n
    q = Deque.new([root])

    while q.size > 0
      v = q.shift
      g[v].each do |nv|
        next if seen[nv]
        seen[nv] = true
        yield v, nv, ans
        q << nv
      end
    end
    return ans
  end

  # 深さ優先検索
  #
  # yield v, 行き掛け := ENTER = 0
  # yield v, 帰り掛け := LEAVE = 1
  def dfs(root = 0)
    seen = [false] * n
    seen[root] = true
    q = Deque.new([~root, root])

    while q.size > 0
      v = q.pop
      if v < 0
        yield ~v, LEAVE
      else
        yield v, ENTER

        g[v].each do |nv|
          next if seen[nv]
          seen[nv] = true
          q << ~nv
          q << nv
        end
      end
    end
  end

  # *root*からの距離
  def depth(root = 0)
    bfs(root) do |v, nv, ans|
      ans[nv] = ans[v] + 1
    end
  end

  # *root*を根とした時の親
  def parent(root = 0)
    bfs(root, -1) do |v, nv, ans|
      ans[nv] = v
    end
  end

  # *root*を根としたオイラーツアー
  def euler_tour
    enter = [-1] * n
    leave = [-1] * n
    index = [] of Int32

    dfs(root = 0) do |v, dir|
      case dir
      when ENTER
        enter[v] = index.size
        index << v
      when LEAVE
        leave[v] = index.size
        index << ~v
      end
    end

    {enter, leave, index}
  end

  # オイラーツアーを利用した最小共通祖先
  def lca
    dep = depth
    par = parent
    ent, lev, idx = euler_tour

    val = idx.map do |i|
      i >= 0 ? {dep[i], i} : {dep[par[~i]], par[~i]}
    end

    st = SegmentTree.range_min_query(values: val, unit: {Int32::MAX, Int32::MAX})

    ->(u : Int32, v : Int32) {
      u, v = v, u if ent[u] > ent[v]
      st[ent[u]..ent[v]][1]
    }
  end
end
