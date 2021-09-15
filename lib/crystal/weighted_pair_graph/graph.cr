# 頂点がTuple(Int32,Int32)である重み付きグラフ
module WeightedPairGraph
  alias V = Tuple(Int32, Int32)
  alias Cost = Int64
  alias E = Tuple(V, Cost)

  class Graph
    getter g : Hash(V, Array(E))
    getter both : Bool
    delegate "[]", to: g

    def initialize(@both = true)
      @g = Hash(V, Array(E)).new { |h, k| h[k] = [] of E }
    end

    def add(y, x, ny, nx, cost = 1_i64)
      v = V.new(y, x)
      nv = V.new(ny, nx)
      cost = Cost.new(cost)

      g[v] << E.new nv, cost
      g[nv] << E.new v, cost if both
    end
  end
end
