require "crystal/priority_queue"
require "crystal/weighted_graph"

# ダイクストラ法により単一始点最短経路を求める
#
# 頂点を`Vertex`、辺を`Edge`、コストを`Cost`として持つ
# 有向グラフを対象とする。
#
# [1] -2-> [2]
#  | \      |
#  7   3    2
#  |     \  |
#  V      v V
# [4] <-2- [3]
# ```

h,w = gets.to_s.split.map(&.to_i)
a = Array.new(h){ gets.to_s.split.map(&.to_i64) }
b = Array.new(h-1){ gets.to_s.split.map(&.to_i64) }

g = Dijkstra.new(2*h*w)

h.times do |y|
  (w-1).times do |x|
    v = y * w + x
    nv = v + 1
    g.add v, nv, a[y][x], both: true
  end
end

(h-1).times do |y|
  w.times do |x|
    v = y * w + x
    nv = v + w
    g.add v, nv, b[y][x], both: false
  end
end

(h-1).times do |y|
  w.times do |x|
    v = (y + 1) * w + x + w * h
    nv = v - w
    g.add v, nv, 1_i64, both: false
  end
end

h.times do |y|
  w.times do |x|
    v = y * w + x
    nv = v + w * h
    g.add v, nv, 1_i64, both: false
    g.add nv, v, 0_i64, both: false
  end
end

ans = g.solve(0)

pp ans[h*w-1]


class Dijkstra < WeightedGraph
  alias Vertex = Int32
  alias Cost = Int64
  alias Edge = Tuple(Vertex,Cost)
  INF = Cost::MAX//2

  # ダイクストラ法により*init*始点の最短経路を求める
  #
  # 始点のパラメータ*init*は0-indexed
  # 結果はコストの配列(`Array(Cost)`)
  def solve(init : Vertex) : Array(Cost)
    q = PriorityQueue(Edge).new { |a, b| a.last > b.last }
    q << {init, 0_i64}

    seen = Array.new(n, false)
    costs = Array.new(n, INF)

    while q.size > 0
      v, cost = q.pop
      next if seen[v]
      seen[v] = true
      costs[v] = cost
      g[v].each do |nv, ncost|
        next if seen[nv]
        q << {nv, cost + ncost}
      end
    end
    return costs
  end
end
