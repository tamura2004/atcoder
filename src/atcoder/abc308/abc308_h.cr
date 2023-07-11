INF = 1e8.to_i64

class Graph
  getter g : Array(Array(Int64))
  getter n : Int32
  getter pairs : Array(Tuple(Int32, Int32))
  delegate "[]", to: g

  def initialize(@n)
    @g = Array.new(n) { Array.new(n, INF) }
    n.times { |i| g[i][i] = 0_i64 }
    @pairs = [] of Tuple(Int32, Int32)
    n.times do |i|
      n.times do |j|
        next unless i < j
        pairs << {i, j}
      end
    end
  end

  def add(v, nv, cost, both = true, origin = 1)
    v = v.to_i - origin
    nv = nv.to_i - origin
    cost = cost.to_i64
    g[v][nv] = cost
    g[nv][v] = cost if both
  end

  # rootを含む最短サイクルを求める
  def shortst_cycle(root = 0)
    root = root.to_i
    depth = Array.new(n, INF)
    parent = Array.new(n, -1)
    label = Array.new(n, -1)
    seen = Array.new(n, false)

    depth[root] = 0_i64
    label[root] = root

    n.times do
      v = (0...n).min_by do |i|
        next INF if seen[i]
        depth[i]
      end
      seen[v] = true
      
      n.times do |nv|
        if depth[v] + g[v][nv] < depth[nv]
          depth[nv] = depth[v] + g[v][nv]
          parent[nv] = v
          label[nv] = (v == root ? nv : label[v])
        end
      end
    end

    i, j = pairs.min_by do |i, j|
      next INF if parent[i] == j || parent[j] == i
      next INF if label[i] == label[j]
      depth[i] + depth[j] + g[i][j]
    end

    len = pairs.min_of do |i, j|
      next INF if parent[i] == j || parent[j] == i
      next INF if label[i] == label[j]
      depth[i] + depth[j] + g[i][j]
    end

    cycle = [] of Int32
    a = i
    b = j

    while a != root
      cycle << a
      a = parent[a]
    end
    cycle << a

    cycle.reverse!

    while b != root
      cycle << b
      b = parent[b]
    end

    return {len, cycle}
  end
end

# 提出版
n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

m.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost, both: true, origin: 1
end

ans = INF
n.times do |v|
  len, res = g.shortst_cycle(v)
  adj = [res[1], res[-1]]

  n.times do |nv|
    next if v == nv
    next if nv == adj[0]
    next if nv == adj[1]
    chmin ans, len + g[v][nv]
  end

  adj.each do |nv|
    save = g[v][nv]
    g[v][nv] = g[nv][v] = INF
    len, res = g.shortst_cycle(v)
    chmin ans, len + save
    g[v][nv] = g[nv][v] = save
  end
end

pp ans == INF ? -1 : ans
