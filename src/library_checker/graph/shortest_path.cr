require "crystal/priority_queue"
require "crystal/weighted_graph/graph"

module WeightedGraph
  # ダイクストラ法により単一始点最短経路を求める
  #
  # 頂点を`V`、辺を`E`、コストを`Cost`として持つ
  # 有向グラフを対象とする。
  #
  # [1] -2-> [2]
  #  | \      |
  #  7   3    2
  #  |     \  |
  #  V      v V
  # [4] <-2- [3]
  # ```
  # g = Graph.new(4)
  # g.add 1, 2, 2
  # g.add 2, 3, 2
  # g.add 1, 3, 3
  # g.add 3, 4, 2
  # g.add 1, 4, 7
  # Dijkstra.new(g).solve.should eq [0, 2, 3, 5]
  # ```
  struct Dijkstra
    INF = Cost::MAX//4
    getter g : Graph
    getter seen : Array(Bool)
    getter depth : Array(Cost)
    getter par : Array(Int32)
    delegate n, to: g

    def initialize(@g)
      @seen = Array.new(n, false)
      @depth = Array.new(n, INF)
      @par = Array.new(n, -1)
    end

    # ダイクストラ法により*root*始点の最短経路を求める
    #
    # 始点のパラメータ*root*は0-indexed
    # 結果はコストの配列(`Array(Cost)`)
    def solve(root = 0)
      seen.fill(false)

      depth.fill(INF)
      depth[root] = 0_i64

      q = PriorityQueue(Tuple(Cost,V,V)).lesser
      q << {0_i64, root, -1}

      while q.size > 0
        cost, v, pv = q.pop
        next if seen[v]
        seen[v] = true
        depth[v] = cost
        par[v] = pv

        g[v].each do |nv, ncost|
          next if seen[nv]
          q << {cost + ncost, nv, v}
        end
      end

      {depth, par}
    end
  end
end

alias Dijkstra = WeightedGraph::Dijkstra
INF = WeightedGraph::Dijkstra::INF

n,m,s,t = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

m.times do
  v,nv,c = gets.to_s.split.map(&.to_i64)
  g.add v, nv, c, origin: 0, both: false
end

dist, par = Dijkstra.new(g).solve(s)
ans = [] of Tuple(Int32,Int32)
x = dist[t]

quit -1 if dist[t] == INF

while s != t
  ans << {par[t], t}
  t = par[t]
end

y = ans.size

puts "#{x} #{y}"
puts ans.reverse.map(&.join(" ")).join("\n")
