macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

alias Edge = Tuple(Int32,Int32,Int64)

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
  INF = Int64::MAX

  getter n : Int32
  getter g : Array(Array(Edge))

  def initialize(@n)
    @g = Array.new(n){ [] of Edge }
  end

  def bellman_ford(init)
    dp = Array.new(n, INF)
    neg = Array.new(n, false)

    dp[init] = 0_i64
    n.times do |i|
      g.each do |v|
        v.each do |from, to, cost|
          if dp[from] != INF
            chmin dp[to], dp[from] + cost
            neg[to] = true if i == n - 1
          end
        end
      end
    end

    # 負閉路から到達できる点
    n.times do |i|
      g.each do |v|
        v.each do |from, to, cost|
          neg[to] = neg[from]
        end
      end
    end
    return ({dp, neg})
  end

  delegate "[]", to: @g
end

n,ml,md = gets.to_s.split.map { |v| v.to_i }
g = Graph.new(n)

(n-1).times do |i|
  g[i+1] << {i+1,i,0_i64}
end

ml.times do
  i,j,cost = gets.to_s.split.map { |v| v.to_i }
  i -= 1
  j -= 1
  cost = cost.to_i64
  g[i] << {i,j,cost}
end

md.times do
  i,j,cost = gets.to_s.split.map { |v| v.to_i }
  i -= 1
  j -= 1
  cost = cost.to_i64
  g[j] << {j,i,-cost}
end

dp, neg = g.bellman_ford(0)
pp dp
