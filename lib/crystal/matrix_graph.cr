require "crystal/weighted_graph"

# 隣接行列による重み付きグラフ
class MatrixGraph < WeightedGraph
  getter g : Array(Array(C))

  def initialize(@n : V)
    @g = Array.new(n) { Array.new(n, INF) }
    n.times { |i| g[i][i] = C.zero }
  end

  # 辺を追加する
  #
  # 頂点の番号は`0-indexed`
  def add_edge(a : Int, b : Int, c : Int) : Nil
    v = V.new(a)
    nv = V.new(b)
    cost = C.new(c)
    g[v][nv] = cost
  end

  # デバッグ用としてグラフを出力する（1-indexed）
  def debug
    n.times do |v|
      n.times do |nv|
        next if v == nv
        next if g[v][nv] == INF
        puts "[%d] -- %2d --> [%d]" % [v + 1, cost, nv + 1]
      end
    end
  end
end
