# 重み付きグラフ
module WeightedGraph
  alias V = Int32
  alias Cost = Int64
  alias E = Tuple(V,Cost)

  class Graph
    getter n : Int32
    getter g : Array(Array(E))
    delegate "[]", to: g

    def initialize(n)
      @n = n.to_i
      @g = Array.new(n){ [] of E }
    end

    def add(v, nv, cost, origin = 1, both = true)
      v = v.to_i - origin
      nv = nv.to_i - origin
      cost = cost.to_i64

      g[v] << E.new nv, cost
      g[nv] << E.new v, cost if both
    end
  end
end
