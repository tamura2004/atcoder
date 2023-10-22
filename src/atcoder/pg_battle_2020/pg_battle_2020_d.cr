require "crystal/graph"
require "crystal/priority_queue"
require "crystal/graph/i_graph"

# ダイクストラ法により、正の重み付きグラフの
# 一点開始、全点への最短距離を求める
class Dijkstra
  INF = Int64::MAX // 4

  getter g : IGraph
  delegate n, to: g

  def initialize(@g)
  end

  def solve(root = 0)
    q = [{0_i64, -1, root.to_i}].to_pq_lesser
    seen = Array.new(n, false)
    depth = Array.new(n, INF)
    parent = Array.new(n, -1_i64)

    while q.size > 0
      cost, pv, v = q.pop
      next if seen[v]
      # pp! [cost,pv+1,v+1]
      seen[v] = true
      depth[v] = cost
      parent[v] = pv

      g.each_with_cost(v) do |nv, ncost|
        next if seen[nv]
        q << {cost + ncost, v, nv}
      end
    end

    [depth, parent]
  end
end

n, m = gets.to_s.split.map(&.to_i64)
g = n.to_g
m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add nv, v, both: false
end

depth, parent = Dijkstra.new(g).solve(n-1)

if depth[0] == Dijkstra::INF
  puts -1
else
  path = [1_i64]
  i = 0
  while parent[i] != -1
    path << parent[i] + 1
    i = parent[i]
  end
  puts path.join(" ")
end
