require "crystal/flow_graph/dinic"
require "crystal/cc"

module FlowGraph
  # Sの元の集合から、Tの元の集合への組が与えられたとき
  # 最大マッチング数を求める
  class MaxBipartiteMatching(S, T)
    private getter pairs : Array(Tuple(S, T))

    def initialize(@pairs)
    end

    def solve
      cc_from = CC.new(pairs.map &.[0])
      cc_to = CC.new(pairs.map &.[1])
      n = cc_from.size
      m = cc_to.size

      root = 0
      goal = n + m + 1
      g = Graph.new(n + m + 2)

      # 始点から左ペアへのパス
      n.times do |i|
        g.add root, i + 1, 1_i64
      end

      # 右ペアから終点へのパス
      m.times do |i|
        g.add i + n + 1, goal, 1_i64
      end

      # 左ペアから右ペアへのパス
      pairs.each do |from, to|
        g.add cc_from[from] + 1, cc_to[to] + n + 1, 1_i64
      end

      Dinic.new(g).solve
    end
  end
end
