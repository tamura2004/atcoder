require "crystal/priority_queue"
require "crystal/segment_tree"

INF = 1e8.to_i64

class Graph
  getter g : Array(Array(Int64))
  getter n : Int32
  delegate "[]", to: g

  def initialize(@n)
    @g = Array.new(n) { Array.new(n, INF) }
    n.times { |i| g[i][i] = 0_i64 }
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
    depth = Array.new(n, INF * 2)
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

    mini = INF * 5
    n.times do |i|
      (i + 1...n).each do |j|
        next if parent[i] == j || parent[j] == i
        next if label[i] == label[j]
        chmin mini, depth[i] + depth[j] + g[i][j]
      end
    end

    n.times do |i|
      (i + 1...n).each do |j|
        next if parent[i] == j || parent[j] == i
        next if label[i] == label[j]
        next if mini != depth[i] + depth[j] + g[i][j]

        res = [] of Int32
        a = i
        b = j
        while a != root
          res << a
          a = parent[a]
        end
        res << a

        res.reverse!

        while b != root
          res << b
          b = parent[b]
        end

        return {mini, res}
      end
    end
    return {mini, [] of Int32}
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