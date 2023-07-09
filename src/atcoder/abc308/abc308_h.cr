require "crystal/priority_queue"
require "crystal/segment_tree"

INF = Int64::MAX

class Graph
  getter g : Array(Array(Tuple(Int32, Int32, Int64))) # nv, edge_index, cost
  getter edges : Array(Tuple(Int32, Int32, Int64))    # v, nv, cost
  getter n : Int32
  getter seen : Array(Bool)
  getter labels : Array(Int32)
  getter edge_use : Set(Int32)
  getter depth : Array(Int64)

  def initialize(n)
    @edges = [] of Tuple(Int32, Int32, Int64)
    @n = n.to_i
    @g = Array.new(n) do
      [] of Tuple(Int32, Int32, Int64)
    end
    @seen = Array.new(n, false)
    @labels = Array.new(n, -1)
    @edge_use = Set(Int32).new
    @depth = Array.new(n, INF)
  end

  def m
    edges.size
  end

  def add(v, nv, cost, both = true, origin = 1)
    v = v.to_i - origin
    nv = nv.to_i - origin
    g[v] << {nv, edges.size, cost}
    g[nv] << {v, edges.size, cost} if both
    edges << {v, nv, cost}
  end

  def each_cost_with_edge_index(v)
    g[v].each do |nv, edge_index, cost|
      yield nv, cost, edge_index
    end
  end

  def each_with_cost(v)
    g[v].each do |nv, edge_index, cost|
      yield nv, cost
    end
  end

  # rootを根とする最短経路木を返す
  # 返り値
  # 頂点のラベル：labels : Array(Int)
  # 辺の使用、不使用：edge_use : Array(Bool)
  # 根からのコスト : depth : Array(Int64)
  def shortst_path_tree(root = 0)
    seen.fill(false)
    labels.fill(-1)
    edge_use.clear
    depth.fill(INF)
    size = 0

    # total_cost, v, pv, edge_index
    pq = PriorityQueue(Tuple(Int64, Int32, Int32, Int32)).lesser
    pq << {0_i64, root.to_i, -1, -1}

    while pq.size > 0
      cost, v, pv, edge_index = pq.pop

      # next if labels[v] != -1
      next if seen[v]
      seen[v] = true

      if pv != -1 && pv != root
        labels[v] = labels[pv]
      else
        labels[v] = v
      end
      if edge_index != -1
        edge_use << edge_index
      end
      depth[v] = cost

      size += 1
      if size == n
        return {labels, edge_use, depth}
      end

      # each_cost_with_edge_index(v) do |nv, ncost, i|
      g[v].each do |nv, i, ncost|
        # next if labels[nv] != -1
        next if seen[nv]
        pq << {cost + ncost, nv, v, i}
      end
    end

    {labels, edge_use, depth}
  end
end

# 提出版
# n, m = gets.to_s.split.map(&.to_i64)
# g = Graph.new(n)

# m.times do
#   v, nv, cost = gets.to_s.split.map(&.to_i64)
#   g.add v, nv, cost, both: true, origin: 1
# end

# # 最大値検証
n = 300
m = n * (n - 1) // 2
g = Graph.new(n)

(0...n.pred).each do |v|
  (v.succ...n).each do |nv|
    cost = rand(80000..100000).to_i64
    g.add v, nv, cost, both: true, origin: 0
  end
end

ans = INF
st = n.to_st_min
is_neighbour = Array.new(n, false)
n.times do |v|
  # puts "begin: #{v} #{Time.local.to_unix}" if v % 10 == 0
  # 根に隣接する子供とコストを求めておく
  # neighbour = [] of Tuple(Int32, Int64)
  cnt = 0
  # is_neighbour = Array.new(n, false)
  is_neighbour.fill(false)
  # st = n.to_st_min
  st.clear
  g.each_with_cost(v) do |nv, cost|
    # neighbour << {nv, cost}
    cnt += 1
    is_neighbour[nv] = true
    st[nv] = cost
  end
  # 子が３未満であれば条件を満たさない
  next if cnt < 3

  labels, edge_use, depth = g.shortst_path_tree(v)

  g.edges.each_with_index do |(from, to, cost), i|
    # 未使用の辺で、両端のラベルが異なり(rootであっても良い）
    next if labels[from] == labels[to]
    next if edge_use.includes?(i)

    # 最も小さい尻尾のコスト
    # 強引に部分永続セグ木
    from_label_min = st[labels[from]]
    st[labels[from]] = INF
    to_label_min = st[labels[to]]
    st[labels[to]] = INF
    from_min = INF
    if is_neighbour[from]
      from_min = st[from]
      st[from] = INF
    end
    to_min = INF
    if is_neighbour[to]
      to_min = st[to]
      st[to] = INF
    end

    tail = st[0..]

    # 戻す
    if is_neighbour[to]
      st[to] = to_min
    end
    if is_neighbour[from]
      st[from] = from_min
    end
    st[labels[to]] = to_label_min
    st[labels[from]] = from_label_min

    chmin ans, depth[from] + depth[to] + cost + tail
  end
end

pp ans == INF ? -1 : ans
