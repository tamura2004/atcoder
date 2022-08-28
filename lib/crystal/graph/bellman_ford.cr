require "crystal/graph/i_graph"

# ベルマンフォード法により最短経路を求める
#
# 負閉路に含まれる点[3][4]を持つ場合
#             +-----+
#             |  1  |
#             +-----+
#               |
#               | 1
#               v
# +---+  -1   +-----+
# | 5 | <---- |  2  |
# +---+       +-----+
#               |
#               | 1
#               v
#             +-----+
#             |  3  | <+
#             +-----+  |
#               |      |
#               | -1   | -1
#               v      |
#             +-----+  |
#             |  4  | -+
#             +-----+
# ```
# g = Graph.new(5)
# g.add 1, 2, 1
# g.add 2, 3, 1
# g.add 3, 4, -1
# g.add 4, 3, -1
# g.add 2, 5, -1
# dp, neg = g.bellman_ford(0)
# dp  # => [0, 1, -8, -7, 0]
# neg # => [false, false, true, true, false]
# ```
struct BellmanFord
  INF = Int64::MAX//4
  getter g : IGraph
  delegate n, to: g

  def initialize(@g)
  end

  # 負閉路に含まれる点 := neg
  def solve(root = 0)
    dp = Array.new(n, INF)
    neg = Array.new(n, false)

    dp[root] = 0_i64
    n.times do |i|
      g.each do |v|
        g.each_with_cost(v) do |nv, cost|
          next if dp[v] == INF
          if dp[nv] > dp[v] + cost
            dp[nv] = dp[v] + cost
            neg[nv] = true if i >= n - 1
          end
        end
      end
    end

    # 負閉路から到達できる点もnegに含める
    n.times do |i|
      g.each do |v|
        g.each_with_cost(v) do |nv, cost|
          neg[nv] ||= neg[v]
        end
      end
    end
    return ({dp, neg})
  end
end
