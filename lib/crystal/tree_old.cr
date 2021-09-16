require "crystal/segment_tree"
require "bit_array"

# 木（重みなし）
class Tree
  ENTER = 0
  LEAVE = 1

  getter n : Int32
  getter g : Array(Array(Int32))
  getter root : Int32
  getter dead : Array(Bool)
  getter subtree : Array(Int32)

  delegate "[]", to: g

  def initialize(n)
    @n = n.to_i
    @g = Array.new(n) { [] of Int32 }
    @root = 0
    @dead = [false] * n
    @subtree = [0] * n
  end

  def initialize(n, &block)
    initialize(n)
    yield self
  end

  # テスト用グラフ
  def self.make(n, type = :random)
    new(n) do |g|
      (1...n).each do |nv|
        v = case type
            when :bus then nv - 1
            when :uni then 0
            else           rand(0...nv)
            end
        g.add v, nv, origin = 0
      end
    end
  end

  # 辺の追加
  def add(v, nv, origin = 1, both = true)
    v = v.to_i - origin
    nv = nv.to_i - origin
    g[v] << nv
    g[nv] << v if both
  end

  # 頂点の追加
  def add_vertex(v, origin = 1, both = true)
    v = v.to_i - origin
    g << [] of Int32
    g[v] << n if n != 0
    g[n] << v if both && n != 0
    @n += 1
  end

  # 親でなく除去されていない次のノード
  def each(v = @root, pv = -1)
    g[v].each do |nv|
      next if nv == pv
      next if dead[nv]
      yield nv
    end
  end

  def with_death(v)
    dead[v] = true
    yield
    dead[v] = false
  end

  def each_centroids(v, &block : Int32 -> Nil)
    c = centroid(v)
    with_death(c) do
      each(c) do |nv|
        each_centroids(nv, &block)
      end

      block.call(c)
    end
  end

  # 幅優先検索
  def bfs(root = @root, pv = -1)
    q = Deque.new([{root, pv}])

    while q.size > 0
      v, pv = q.shift

      each(v, pv) do |nv|
        yield v, nv
        q << {nv, v}
      end
    end
  end

  # 幅優先検索（オブジェクト付）
  def bfs_with_array(init, root = @root, pv = -1)
    ans = [init] * n
    bfs(root, pv) do |v, nv|
      yield v, nv, ans
    end
    ans
  end

  # キューを利用した深さ優先検索
  #
  # yield v, 行き掛け := ENTER = 0
  # yield v, 帰り掛け := LEAVE = 1
  def dfsq(root = @root, pv = -1)
    q = Deque.new([{~root, pv}, {root, pv}])

    while q.size > 0
      v, pv = q.pop
      if v < 0
        yield ~v, LEAVE, pv
      else
        yield v, ENTER, pv

        each(v, pv) do |nv|
          q << {~nv, v}
          q << {nv, v}
        end
      end
    end
  end

  # 深さ優先検索
  #
  # yield v, 行き掛け := ENTER = 0
  # yield v, 帰り掛け := LEAVE = 1
  def dfs(root = @root, &block : Int32, Int32, Int32 -> Nil)
    f = uninitialized Int32, Int32 -> Nil

    f = ->(v : Int32, pv : Int32) do
      block.call(v, ENTER, pv)

      g[v].each do |nv|
        next if nv == pv
        f.call(nv, v)
      end

      block.call(v, LEAVE, pv)
    end

    f.call(root, -1)
  end

  # 帰りがけ順の深さ優先検索
  def dfs_leave(root = @root)
    dfsq(root) do |v, dir|
      next if dir == ENTER
      yield v
    end
  end

  # *root*からの距離
  def depth(root = @root, offset = 0)
    return [0] if n == 1

    bfs_with_array(-1, root) do |v, nv, ans|
      ans[v] = offset if ans[v] == -1
      ans[nv] = ans[v] + 1
    end
  end

  # 距離別にカウント
  def depth_count(root = @root, offset = 0)
    depth(root, offset).each_with_object([0] * n) do |v, ans|
      ans[v] += 1
    end
  end

  # *root*を根とした時の親
  def parent(root = @root)
    bfs_with_array(-1, root) do |v, nv, ans|
      ans[nv] = v
    end
  end

  # *root*を根とした時に葉か
  def leaf(root = @root)
    bfs_with_array(true, root) do |v, nv, ans|
      ans[v] = false
    end
  end

  # ノードの次数
  def degree
    (0...n).map do |v|
      g[v].size
    end
  end

  # *root*を根としたオイラーツアー
  def euler_tour(root = @root)
    enter = [-1] * n
    leave = [-1] * n
    index = [] of Int32

    dfsq(root) do |v, dir|
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
  def lca(root = @root, origin = 0)
    dep = depth
    par = parent
    ent, lev, idx = euler_tour

    val = idx.map do |i|
      i >= 0 ? {dep[i], i} : {dep[par[~i]], par[~i]}
    end

    st = SegmentTree.range_min_query(values: val, unit: {Int32::MAX, Int32::MAX})

    ->(u : Int32, v : Int32) {
      u -= origin
      v -= origin
      u, v = v, u if ent[u] > ent[v]
      st[ent[u]..ent[v]][1] + origin
    }
  end

  # 部分木の大きさ
  def set_subtree(v = @root, pv = -1)
    subtree[v] = 1
    each(v, pv) do |nv|
      set_subtree(nv, v)
      subtree[v] += subtree[nv]
    end
  end

  # 子ノード（隣接点から親を除外）
  def children(root = @root)
    ans = Array.new(n) { [] of Int32 }
    bfs(root) do |v, nv|
      ans[v] << nv
    end
    ans
  end

  # 重心
  def centroid(v = @root)
    set_subtree(v, -1)
    dfs_centroid(v, -1, subtree[v])
  end

  private def dfs_centroid(v, pv, n)
    each(v, pv) do |nv|
      return dfs_centroid(nv, v, n) if subtree[nv] > n // 2
    end

    return v
  end

  # デバッグ用：アスキーアートで可視化
  def debug(origin = 0)
    case n
    when 0
      puts "++"
      puts "++"
      return
    when 1
      puts "+---+"
      puts "| #{origin} |"
      puts "+---+"
      return
    end

    File.open("debug.dot", "w") do |fh|
      fh.puts "digraph tree {"
      bfs do |v, nv|
        fh.puts "  #{v + origin} -- #{nv + origin}"
      end
      fh.puts "}"
    end
    puts `cat debug.dot | graph-easy --from=dot --as_ascii`
  end
end
