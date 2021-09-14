# 隣接行列によるグラフ
class MatrixGraph
  INF = Int64::MAX//4
  getter n : Int32
  getter g : Array(Array(Int64))
  delegate "[]", to: g

  def initialize(n)
    @n = n.to_i
    @g = Array.new(n) { Array.new(n, INF) }
    n.times { |i| g[i][i] = 0_i64 }
  end

  # 辺を追加する
  #
  # 頂点の番号は`0-indexed`
  def add(v, nv, cost = 1_i64, origin = 1, both = true)
    v = v.to_i - origin
    nv = nv.to_i - origin
    g[v][nv] = cost
    g[nv][v] = cost if both
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
