require "crystal/weighted_graph"

# 隣接リストによる重み付きグラフ
class ListGraph < WeightedGraph
  getter g : Array(Array(E))

  def initialize(@n : V)
    @g = Array.new(n) { [] of E }
  end

  # 辺を追加する
  #
  # 頂点の番号は`0-indexed`
  def add_edge(a : Int, b : Int, c : Int) : Nil
    v = V.new(a)
    nv = V.new(b)
    cost = C.new(c)
    g[v] << E.new(nv, cost)
  end

  # 有向辺を逆向きにしたグラフを返す
  def reverse : self
    self.class.new(n).tap do |ans|
      n.times do |v|
        g[v].each do |nv, cost|
          ans[nv] << {v, cost}
        end
      end
    end
  end

  # デバッグ用としてグラフを出力する（1-indexed）
  def debug
    n.times do |v|
      g[v].each do |nv, cost|
        puts "[%d] -- %2d --> [%d]" % [v + 1, cost, nv + 1]
      end
    end
  end
end
