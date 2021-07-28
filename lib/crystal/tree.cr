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

  # 幅優先検索
  def bfs(root = 0, init : _ = 0, pv = -1)
    ans = [init] * n
    q = Deque.new([{root, pv}])

    while q.size > 0
      v, pv = q.shift

      g[v].each do |nv|
        next if nv == pv
        yield v, nv, ans
        q << {nv, v}
      end
    end
    return ans
  end

  # キューを利用した深さ優先検索
  #
  # yield v, 行き掛け := ENTER = 0
  # yield v, 帰り掛け := LEAVE = 1
  def dfsq(root = 0, pv = -1)
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
  def dfs(root = 0, &block : Int32, Int32, Int32 -> Nil)
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
  def dfs_leave(root = 0)
    dfsq(root) do |v, dir|
      next if dir == ENTER
      yield v
    end
  end

  # *root*からの距離
  def depth(root = 0)
    bfs(root, 0) do |v, nv, ans|
      ans[nv] = ans[v] + 1
    end
  end

  # *root*を根とした時の親
  def parent(root = 0)
    bfs(root, -1) do |v, nv, ans|
      ans[nv] = v
    end
  end

  # *root*を根とした時に葉か
  def leaf(root = 0)
    bfs(root, true) do |v, nv, ans|
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
  def euler_tour(root = 0)
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
  def subtree(root = 0)
    pa = parent(root)
    dp = [1] * n
    dfs_leave(root) do |v|
      dp[pa[v]] += dp[v] if pa[v] != -1
    end
    dp
  end

  # 子ノード（隣接点から親を除外）
  def children(root = 0)
    ans = Array.new(n) { [] of Int32 }
    bfs(root) do |v, nv|
      ans[v] << nv
    end
    ans
  end

  # 重心
  def centroid(root = 0)
    return 0 if n == 1
    
    s = subtree(root)
    p = parent(root)

    v = root
    while true
      nex = g[v].select(&.!= p[v])
      size = nex.max_of { |v| s[v] }
      nv = nex.max_by { |v| s[v] }
      return v if size <= n // 2
      v = nv
    end
  end

  # 重心分解
  def centroid_decomposition(root = 0)
    pv = centroid(root)
    s = subtree(pv)

    trees = g[pv].map do |v|
      idx = [-1] * n
      idx[v] = i = 0

      tree = Tree.new(s[v]) do |tr|
        bfs(v, 0, pv) do |v, nv|
          idx[nv] = (i += 1)
          tr.add idx[v], idx[nv], origin = 0, both = true
        end
      end
      { tree, idx }
    end

    {pv, trees}
  end

  # デバッグ用：アスキーアートで可視化
  def debug(origin = 0)
    if n == 1
      puts "+---+"
      puts "| 0 |"
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
