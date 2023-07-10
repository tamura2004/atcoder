require "crystal/priority_queue"
require "crystal/segment_tree"

class Graph
  INF = 1e8.to_i64
  getter g : Array(Array(Int64))
  getter n : Int32

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
  end
end

# 提出版
n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

m.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost, both: true, origin: 1
end

pp g.shortst_cycle(1)

# # 最大値検証
# n = 300
# m = n * (n - 1) // 2
# g = Graph.new(n)

# (0...n.pred).each do |v|
#   (v.succ...n).each do |nv|
#     cost = rand(80000..100000).to_i64
#     g.add v, nv, cost, both: true, origin: 0
#   end
# end

# ans = INF
# st = n.to_st_min
# is_neighbour = Array.new(n, false)
# n.times do |v|
#   # puts "begin: #{v} #{Time.local.to_unix}" if v % 10 == 0
#   # 根に隣接する子供とコストを求めておく
#   # neighbour = [] of Tuple(Int32, Int64)
#   cnt = 0
#   # is_neighbour = Array.new(n, false)
#   is_neighbour.fill(false)
#   # st = n.to_st_min
#   st.clear
#   g.each_with_cost(v) do |nv, cost|
#     # neighbour << {nv, cost}
#     cnt += 1
#     is_neighbour[nv] = true
#     st[nv] = cost
#   end
#   # 子が３未満であれば条件を満たさない
#   next if cnt < 3

#   labels, edge_use, depth = g.shortst_path_tree(v)

#   g.edges.each_with_index do |(from, to, cost), i|
#     # 未使用の辺で、両端のラベルが異なり(rootであっても良い）
#     next if labels[from] == labels[to]
#     next if edge_use.includes?(i)

#     # 最も小さい尻尾のコスト
#     # 強引に部分永続セグ木
#     from_label_min = st[labels[from]]
#     st[labels[from]] = INF
#     to_label_min = st[labels[to]]
#     st[labels[to]] = INF
#     from_min = INF
#     if is_neighbour[from]
#       from_min = st[from]
#       st[from] = INF
#     end
#     to_min = INF
#     if is_neighbour[to]
#       to_min = st[to]
#       st[to] = INF
#     end

#     tail = st[0..]

#     # 戻す
#     if is_neighbour[to]
#       st[to] = to_min
#     end
#     if is_neighbour[from]
#       st[from] = from_min
#     end
#     st[labels[to]] = to_label_min
#     st[labels[from]] = from_label_min

#     chmin ans, depth[from] + depth[to] + cost + tail
#   end
# end

# pp ans == INF ? -1 : ans
