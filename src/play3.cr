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
# g = Dijkstra.new(4)
# g.add "1 2 2"
# g.add "2 3 2"
# g.add "1 3 3"
# g.add "3 4 2"
# g.add "1 4 7"
# g.solve(0) # => [0,2,3,5]
# ```

INF = Int64::MAX//2
N = 10_000_000_000_i64

class Dijkstra < WeightedGraph
  alias Vertex = Int32
  alias Cost = Int64
  alias Edge = Tuple(Vertex,Cost)

  # ダイクストラ法により*init*始点の最短経路を求める
  #
  # 始点のパラメータ*init*は0-indexed
  # 結果はコストの配列(`Array(Cost)`)
  def solve(init : Vertex, limit) : Array(Cost)
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
        next if cost + ncost > limit
        q << {nv, cost + ncost}
      end
    end
    return costs
  end
end


n,m,l = gets.to_s.split.map(&.to_i64)
g = Dijkstra.new(n.to_i * (m+1))

m.times do |i|
  a,b,c = gets.to_s.split.map(&.to_i64)
  0.upto(m) do |j|
    aa = a + j * n
    bb = b + j * n
    g.add aa, bb, c, both: false, origin: 1
    g.add bb, aa + n, c, both: false, origin: 1
  end
end

ans = g.solve(0,l)
# pp ans
0.upto(m) do |i|
  ii = n * (i + 1) - 1
  if ans[ii] < INF
    puts i
    exit
  end
end

puts -1

