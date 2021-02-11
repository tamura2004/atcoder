macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end


# ベルマンフォード法により最短経路を求める
#
# ```
# g = Graph.new(3)
# g[0] << {0, 1, 10_i64}
# g[1] << {1, 2, -5_i64}
# g[0] << {0, 2, 6_i64}
# dp, neg = g.bellman_ford(0)
# dp[2].should eq 5
# ```
class Graph
  alias Edge = Tuple(Int32,Int32,Int64)
  
  INF = Int64::MAX

  getter n : Int32
  getter g : Array(Array(Edge))

  def initialize(@n)
    @g = Array.new(n){ [] of Edge }
  end

  def add(a, b, c)
    g[a - 1] << {a - 1, b - 1, c.to_i64}
  end

  # 負閉路に含まれる点 := neg
  def bellman_ford(init)
    dp = Array.new(n, INF)
    neg = Array.new(n, false)

    dp[init] = 0_i64
    n.times do |i|
      g.each do |v|
        v.each do |from, to, cost|
          next if dp[from] == INF
          if dp[to] > dp[from] + cost
            dp[to] = dp[from] + cost
            neg[to] = true if i >= n - 1
          end
        end
      end
    end

    # 負閉路から到達できる点もnegに含める
    n.times do |i|
      g.each do |v|
        v.each do |from, to, cost|
          neg[to] ||= neg[from]
        end
      end
    end
    return ({dp, neg})
  end

  delegate "[]", to: @g
end
