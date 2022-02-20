require "crystal/priority_queue"
require "crystal/weighted_graph/graph"
include WeightedGraph

struct Dijkstra
  alias Keikan = Int64
  alias Cost = Int64
  alias State = Tuple(Cost, Keikan)
  alias Nex = Tuple(State, Int32)

  getter g : Graph
  getter seen : Array(Bool)
  getter keikans : Array(Keikan)
  getter ans : Array(State?)
  delegate n, to: g

  def initialize(@g, @keikans)
    @seen = Array.new(n, false)
    @ans = Array.new(n, nil.as(State?))
  end

  # ダイクストラ法により*root*始点の最短経路を求める
  #
  # 始点のパラメータ*root*は0-indexed
  # 結果はコストの配列(`Array(Cost)`)
  def solve(root = 0)
    seen.fill(false)

    q = PriorityQueue(Nex).lesser
    q << Nex.new(State.new(0_i64, -keikans[root]), root)

    while q.size > 0
      state, v = q.pop
      cost, keikan = state

      next if seen[v]
      seen[v] = true
      ans[v] = state

      g[v].each do |nv, ncost|
        next if seen[nv]
        q << Nex.new(State.new(cost + ncost, keikan - keikans[nv]), nv)
      end
    end

    ans
  end
end

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
keikans = gets.to_s.split.map(&.to_i64)

m.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost
end

pp -Dijkstra.new(g,keikans).solve[-1].not_nil![-1]
