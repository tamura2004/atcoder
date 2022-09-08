# 辺i = par[vi] - viとする
# 根の辺の色はダミーとしてINFを入れる
# 上からdfsで更新
# 親の色を一つで集合Sを初期化
# 各子についてmexを割り当ててSに追加

require "crystal/graph"

class Mex
  getter seed : Int32
  getter s : Set(Int32)
  getter id : Int32

  def initialize(@seed, @id = 0)
    @s = Set.new([seed])
  end

  def get
    while id.in?(s)
      @id += 1
    end
    @id.tap { s << id }
  end
end

n = gets.to_s.to_i
g = Graph.new(n)
(n+1).times do
  g.read
end

dp = Array.new(n-1, 0)

dfs = uninitialized (Int32, Int32, Int32, Int32) -> Nil
dfs = -> (v : Int32, pv : Int32, color: Int32, edge_id : Int32) do
  dp[edge_id] = color if edge_id != -1
  mex = Mex.new(color, 1)

  g.each_with_index(v) do |nv, n_edge_id|
    next if nv == pv
    dfs.call(nv, v, mex.get, n_edge_id)
  end
end
dfs.call(0, -1, 1e9.to_i, -1)

puts dp.max
puts dp.join("\n")
