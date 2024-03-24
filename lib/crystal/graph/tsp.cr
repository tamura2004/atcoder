require "crystal/graph/i_matrix_graph"

# 巡回セールスマン
class Tsp
  getter g : IMatrixGraph
  delegate n, to: g

  def initialize(@g)
  end

  def solve(dp)
    (1<<n).times do |s|
      n.times do |v|
        next if s.bit(v) == 0
        next if dp[s][v] == INF
        n.times do |nv|
          next if s.bit(nv) == 1
          t = s | (1 << nv)
          next if g[v, nv] == INF
          chmin dp[t][nv], dp[s][v] + g[v, nv]
        end
      end
    end
    dp
  end
end
