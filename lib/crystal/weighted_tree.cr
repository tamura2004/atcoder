# 辺重み付き木
#
# ```
# g = WeightedTree.new(3)
# g.add 1, 2, 10, both: false, origin: 1
# g.add 2, 3, 20, both: false, origin: 1
# dp = Array.new(3, -1)
# dp[0] = 0
# g.bfs do |v, nv, w, q|
#   next if dp[nv] != -1
#   dp[nv] = dp[v] + w
#   q << nv
# end # => [0, 10, 30]
# ```
class WeightedTree
  getter n : Int32
  getter g : Array(Array(Tuple(Int32, Int64)))

  def initialize(n)
    @n = n.to_i
    @g = Array.new(@n) { [] of Tuple(Int32, Int64) }
  end

  # 辺の追加
  def add(v, nv, w, both = false, origin = 0)
    v = v.to_i - origin
    nv = nv.to_i - origin
    w = w.to_i64
    g[v] << {nv, w}
    g[nv] << {v, w} if both
  end

  # 幅優先検索
  def bfs(init = 0)
    q = Deque.new([init])
    while q.size > 0
      v = q.shift
      g[v].each do |nv, w|
        yield v, nv, w, q
      end
    end
  end
end
