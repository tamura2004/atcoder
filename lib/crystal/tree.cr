require "crystal/segment_tree"
require "bit_array"

# 木（重みなし）
class Tree
  ENTER = 0
  LEAVE = 1

  getter n : Int32
  getter g : Array(Array(Int32))
  getter root : Int32
  getter removed : BitArray

  delegate "[]", to: g
  def_equals n, g, root, removed

  def initialize(n)
    @n = n.to_i
    @g = Array.new(n) { [] of Int32 }
    @root = 0
    @removed = BitArray.new(n)
  end

  def initialize(n, &block)
    initialize(n)
    yield self
  end

  def initialize(@n, @g, @root, @removed)
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

  # 幅優先検索
  def bfs(root = @root, pv = -1)
    q = Deque.new([{root, pv}])

    while q.size > 0
      v, pv = q.shift

      g[v].each do |nv|
        next if nv == pv
        next if removed[nv]
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

        g[v].each do |nv|
          next if nv == pv
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
  def lca(origin = 0)
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
  def subtree(root = @root)
    pa = parent(root)
    dp = [1] * n
    dfs_leave(root) do |v|
      dp[pa[v]] += dp[v] if pa[v] != -1
    end
    dp
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
  def centroid(root = @root)
    return 0 if n == 1

    s = subtree(root)
    p = parent(root)

    v = root
    while true
      nex = g[v].select(&.!= p[v])
      size = nex.max_of { |v| s[v] }
      return v if size <= n // 2
      v = nex.max_by { |v| s[v] }
    end
  end

  # 重心分解
  def centroid_decomposition(root = @root)
    pv = centroid(root)
    s = subtree(pv)

    # {部分木の番号 -1は重心, 頂点番号}
    dic = (1..n).map do
      {-1, 0}
    end

    trees = g[pv].map_with_index do |v, j|
      idx = [-1] * n
      idx[v] = i = 0
      dic[v] = {j, i}

      Tree.new(s[v]) do |tr|
        bfs_with_array(0, v, pv) do |v, nv|
          idx[nv] = (i += 1)
          dic[nv] = {j, i}
          tr.add idx[v], idx[nv], origin = 0, both = true
        end
      end
    end

    {pv, trees, dic}
  end

  def centroid_decomposition_tree
    trees = [self]
    centroids = [] of Int32
    depth_counts_from_centroid = [] of Array(Int32)
    depth_counts_from_root = [] of Array(Int32)
    depth_from_root = [] of Array(Int32)
    dics = [] of Array(Tuple(Int32,Int32))
    g = self.class.new(1)

    q = Deque.new([0])
    while q.size > 0
      v = q.shift
      tree = trees[v]

      centroid, subtrees, dic = tree.centroid_decomposition
      centroids << centroid
      dics << dic.map { |tree_index, v| ({ tree_index + g.n, v }) }
      depth_counts_from_centroid << tree.depth_count(root: centroid, offset: 0)
      depth_counts_from_root << tree.depth_count(root: 0, offset: 1)
      depth_from_root << tree.depth(root: 0, offset: 1)

      subtrees.each do |subtree|
        trees << subtree
        q << g.n
        g.add_vertex(v, origin: 0)
      end
    end

    {
      trees,
      centroids,
      dics,
      depth_counts_from_centroid,
      depth_counts_from_root,
      depth_from_root,
      g
    }
  end

  # vを取り除いた残りの部分木
  def remove(v)
    next_removed = removed.dup
    next_removed[v] = true

    g[v].map do |nv|
      self.class.new(@n, @g, nv, next_removed)
    end
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
