require "crystal/priority_queue"

class Graph
  getter g : Array(Array(Tuple(Int32,Int32))) # nv, edge_index
  getter edges : Array(Tuple(Int32,Int32,Int64)) # v, nv, cost
  getter n : Int32

  def initialize(n)
    @edges = [] of Tuple(Int32,Int32,Int64)
    @n = n.to_i
    @g = Array.new(n) do
      [] of Tuple(Int32,Int32)
    end
  end

  def m
    edges.size
  end

  def add(v, nv, cost, both = true, origin = 1)
    v = v.to_i - origin
    nv = nv.to_i - origin
    g[v] << { nv, edges.size }
    g[nv] << { v, edges.size } if both
    edges << { v, nv, cost }
  end

  def each_cost_with_edge_index(v)
    g[v].each do |nv, edge_index|
      cost = edges[edge_index][2]
      yield nv, cost, edge_index
    end
  end

  def each_with_cost(v)
    g[v].each do |nv, edge_index|
      cost = edges[edge_index][2]
      yield nv, cost
    end
  end

  # rootを根とする最短経路木を返す
  # 返り値
  # 頂点のラベル：labels : Array(Int)
  # 辺の使用、不使用：edge_use : Array(Bool)
  # 根からのコスト : depth : Array(Int64)
  def shortst_path_tree(root = 0)
    labels = Array.new(n, -1)
    edge_use = Array.new(m, false)
    depth = Array.new(n, Int64::MAX)

    # total_cost, v, pv, edge_index
    pq = PriorityQueue(Tuple(Int64,Int32,Int32,Int32)).lesser
    pq << { 0_i64, root.to_i, -1, -1 }

    while pq.size > 0
      cost, v, pv, edge_index = pq.pop

      next if labels[v] != -1

      if pv != -1 && pv != root
        labels[v] = labels[pv]
      else
        labels[v] = v
      end
      if edge_index != -1
        edge_use[edge_index] = true
      end
      depth[v] = cost

      each_cost_with_edge_index(v) do |nv, ncost, i|
        next if labels[nv] != -1
        pq << { cost + ncost, nv, v, i}
      end
    end

    {labels, edge_use, depth}
  end
end

n, m = gets.to_s.split.map(&.to_i64)
g = Graph.new(n)

m.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost, both: true, origin: 1
end

ans = Int64::MAX
n.times do |v|
  # 根に隣接する子供とコストを求めておく
  neighbour = [] of Tuple(Int32,Int64)
  g.each_with_cost(v) do |nv, cost|
    neighbour << {nv, cost}
  end
  # 子が３未満であれば条件を満たさない
  next if neighbour.size < 3

  labels, edge_use, depth = g.shortst_path_tree(v)
  # pp! labels
  # pp! edge_use.zip(0..).zip(g.edges)
  # pp! depth
  # exit
  g.edges.each_with_index do |(from, to, cost), i|
    # 未使用の辺で、両端のラベルが異なり(rootであっても良い）
    next if edge_use[i]
    next if labels[from] == labels[to]

    # もっとも小さい尻尾のコスト
    # rootと隣接しているけど、直接繋がっていない子に注意！
    tail = neighbour.min_of do |j, tcost|
      if labels[from] == j || labels[to] == j || from == j || to == j
        Int64::MAX
      else
        tcost
      end
    end

    pre = ans
    chmin ans, depth[from] + depth[to] + cost + tail
  end
end

pp ans == Int64::MAX ? -1 : ans
